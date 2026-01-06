import 'dart:convert';
import 'dart:io';
import 'package:jaspr/server.dart' hide Request, Response, Handler;
import 'package:port/main_layout.dart';
import 'package:port/pages/contact_page.dart';
import 'package:port/pages/home_page.dart';
import 'package:port/pages/info_page.dart';
import 'package:port/pages/project_detail_page.dart';
import 'package:relic/relic.dart' hide Message;
import 'package:relic/io_adapter.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailServer {
  static final String smtpHost = Platform.environment['SMTP_HOST'] ?? 'smtp.gmail.com';
  static final int smtpPort = Platform.environment['SMTP_PORT'] != null 
      ? int.parse(Platform.environment['SMTP_PORT']!) 
      : 587;
  static final String smtpUser = Platform.environment['SMTP_USER'] ?? 'your-email@gmail.com';
  static final String smtpPassword = Platform.environment['SMTP_PASSWORD'] ?? 'your-app-password';
  static final String receiverEmail = Platform.environment['RECEIVER_EMAIL'] ?? 'your-email@gmail.com';

  Future<void> start() async {
    final app = RelicApp();

    // CRITICAL: CORS middleware must be FIRST, before logging
    app.use('/', _corsMiddleware());
    app.use('/', _loggingMiddleware());

    // Health check endpoint
    app.get('/health', (Request request) {
      return Response.ok(body: Body.fromString('Server is running'));
    });

    // Contact form endpoint - Handle both OPTIONS and POST
    app.options('/contact/send', _handleCorsPreflight);
    app.post('/contact/send', _handleContactForm);

    // Serve static files from 'web' directory
    final webDir = Directory('web');
    if (await webDir.exists()) {
      app.anyOf(
        {Method.get, Method.head},
        '/**',
        StaticHandler.directory(
          webDir,
          cacheControl: (req, fileInfo) => CacheControlHeader(
            maxAge: 3600,
            publicCache: true,
          ),
        ).asHandler,
      );
    } else {
      print('⚠️  Warning: web directory not found');
    }

    // HTML Routes
    app.get('/', _serveJasprHome);
    app.get('/info', _serveJasprInfo);
    app.get('/contact', _serveJasprContact);
    app.get('/projects/:id', _serveJasprProjectsDetails);

    // Start server
    final server = await app.serve(
      address: InternetAddress.anyIPv4,
      port: 8080,
      shared: true,
    );

    print('✅ Server running on http://localhost:${server.port}');
    print('📧 Email endpoint: http://localhost:${server.port}/contact/send');
    print('📁 Static files: http://localhost:${server.port}/');
  }

  // Handle CORS preflight
  Response _handleCorsPreflight(Request request) {
    return Response.ok(
      body: Body.empty(),
      headers: Headers.build((h) {
        h['Access-Control-Allow-Origin'] = ['*'];
        h['Access-Control-Allow-Methods'] = ['GET, POST, PUT, DELETE, OPTIONS'];
        h['Access-Control-Allow-Headers'] = ['Content-Type, Authorization, Accept'];
        h['Access-Control-Max-Age'] = ['86400']; // Cache preflight for 24 hours
      }),
    );
  }

  // Contact form handler
  Future<Response> _handleContactForm(Request request) async {
    try {
      print('📧 Received contact form request');
      
      final bodyText = await request.readAsString();
      print('📧 Body: $bodyText');
      
      final data = jsonDecode(bodyText) as Map<String, dynamic>;

      final name = data['name'] as String?;
      final email = data['email'] as String?;
      final subject = data['subject'] as String?;
      final message = data['message'] as String?;

      if (name == null || name.isEmpty || 
          email == null || email.isEmpty || 
          message == null || message.isEmpty) {
        return Response.badRequest(
          body: Body.fromString(
            jsonEncode({'success': false, 'error': 'Missing required fields'}),
            mimeType: MimeType.json,
          ),
        );
      }

      final success = await _sendEmail(
        name: name,
        email: email,
        subject: subject ?? 'Contact Form Submission',
        message: message,
      );

      if (success) {
        return Response.ok(
          body: Body.fromString(
            jsonEncode({'success': true, 'message': 'Email sent successfully'}),
            mimeType: MimeType.json,
          ),
        );
      } else {
        return Response(
          500,
          body: Body.fromString(
            jsonEncode({'success': false, 'error': 'Failed to send email'}),
            mimeType: MimeType.json,
          ),
        );
      }
    } catch (e, stackTrace) {
      print('❌ Error handling contact form: $e');
      print('Stack trace: $stackTrace');
      return Response(
        500,
        body: Body.fromString(
          jsonEncode({'success': false, 'error': 'Server error: $e'}),
          mimeType: MimeType.json,
        ),
      );
    }
  }

  // Serve Jaspr pages
  Future<Response> _serveJasprHome(Request request) async {
    return _renderJasprComponent(HomePage(), 'Portfolio - Home');
  }

  Future<Response> _serveJasprInfo(Request request) async {
    return _renderJasprComponent(InfoPage(), 'Portfolio - Info');
  }

  Future<Response> _serveJasprContact(Request request) async {
    return _renderJasprComponent(ContactPage(), 'Portfolio - Contact');
  }

  Future<Response> _serveJasprProjectsDetails(Request request) async {
    final id = request.rawPathParameters[#id];
    return _renderJasprComponent(
      ProjectDetailPage(projectId: id ?? ''),
      'Portfolio - Project',
    );
  }

  // Helper to render Jaspr components
  Future<Response> _renderJasprComponent(Component component, String title) async {
    final rendered = await renderComponent(
      MainLayout(child: component),
      request: null,
    );

    final htmlString = utf8.decode(rendered.body);

    final headers = Headers.build((h) {
      rendered.headers.forEach((key, values) {
        h[key] = values;
      });
    });

    return Response.ok(
      body: Body.fromString(htmlString, mimeType: MimeType.html),
      headers: headers,
    );
  }

  // Send email
  Future<bool> _sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    try {
      final smtpServer = gmail(smtpUser, smtpPassword);

      final emailMessage = Message()
        ..from = Address(smtpUser, 'Portfolio Contact Form')
        ..recipients.add(receiverEmail)
        ..subject = '📧 Portfolio Contact: $subject'
        ..html = _buildEmailTemplate(
          name: name,
          email: email,
          subject: subject,
          message: message,
        );

      final sendReport = await send(emailMessage, smtpServer);
      print('✅ Email sent: ${sendReport.toString()}');
      return true;
    } catch (e) {
      print('❌ Failed to send email: $e');
      return false;
    }
  }

  String _buildEmailTemplate({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) {
    return '''
<!DOCTYPE html>
<html>
<head>
  <style>
    body { 
      font-family: 'SF Mono', monospace; 
      line-height: 1.6; 
      color: #f5f5f5;
      background: #0a0a0a;
      margin: 0;
      padding: 0;
    }
    .container { 
      max-width: 600px; 
      margin: 0 auto; 
      padding: 20px; 
    }
    .header { 
      background: #00ff41; 
      color: #0a0a0a; 
      padding: 30px 20px; 
      text-align: center;
      border-radius: 8px 8px 0 0;
    }
    .header h1 {
      margin: 0;
      font-size: 24px;
      text-transform: uppercase;
      letter-spacing: 2px;
    }
    .content { 
      background: #111; 
      padding: 30px; 
      border-radius: 0 0 8px 8px;
    }
    .field { 
      margin-bottom: 20px;
      padding: 15px;
      background: #0a0a0a;
      border-left: 3px solid #00ff41;
      border-radius: 4px;
    }
    .field-label { 
      font-size: 11px; 
      color: #666; 
      text-transform: uppercase; 
      letter-spacing: 1px;
      margin-bottom: 8px;
    }
    .field-value { 
      font-size: 14px; 
      color: #f5f5f5;
      word-wrap: break-word;
    }
    .message-box {
      background: #0a0a0a;
      padding: 20px;
      border-radius: 4px;
      white-space: pre-wrap;
      line-height: 1.8;
    }
    .footer { 
      text-align: center; 
      padding: 20px; 
      font-size: 12px; 
      color: #666; 
    }
    .reply-button {
      display: inline-block;
      background: #00ff41;
      color: #0a0a0a;
      padding: 12px 30px;
      text-decoration: none;
      border-radius: 4px;
      font-weight: bold;
      text-transform: uppercase;
      letter-spacing: 1px;
      margin: 20px 0;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1>📧 New Contact Message</h1>
    </div>
    <div class="content">
      <div class="field">
        <div class="field-label">From</div>
        <div class="field-value">$name</div>
      </div>
      
      <div class="field">
        <div class="field-label">Email</div>
        <div class="field-value">
          <a href="mailto:$email" style="color: #00ff41; text-decoration: none;">$email</a>
        </div>
      </div>
      
      <div class="field">
        <div class="field-label">Subject</div>
        <div class="field-value">$subject</div>
      </div>
      
      <div class="field">
        <div class="field-label">Message</div>
        <div class="field-value">
          <div class="message-box">$message</div>
        </div>
      </div>
      
      <center>
        <a href="mailto:$email?subject=Re: $subject" class="reply-button">
          Reply to $name
        </a>
      </center>
    </div>
    <div class="footer">
      <p>Sent from your portfolio contact form</p>
      <p>© ${DateTime.now().year} Portfolio. Powered by Dart + Relic</p>
    </div>
  </div>
</body>
</html>
    ''';
  }

  // CORS Middleware - MUST add headers to ALL responses
  Middleware _corsMiddleware() {
    return (Handler next) {
      return (Request request) async {
        print('🔒 CORS: ${request.method.name} ${request.url.path}');
        
        // Handle preflight OPTIONS
        if (request.method == Method.options) {
          print('✅ CORS: Preflight request');
          return Response.ok(
            body: Body.empty(),
            headers: Headers.build((h) {
              h['Access-Control-Allow-Origin'] = ['*'];
              h['Access-Control-Allow-Methods'] = ['GET, POST, PUT, DELETE, OPTIONS'];
              h['Access-Control-Allow-Headers'] = ['Content-Type, Authorization, Accept'];
              h['Access-Control-Max-Age'] = ['86400'];
            }),
          );
        }

        // Process request
        final result = await next(request);

        // Add CORS headers to response
        if (result is Response) {
          return result.copyWith(
            headers: result.headers.transform((h) {
              h['Access-Control-Allow-Origin'] = ['*'];
              h['Access-Control-Allow-Methods'] = ['GET, POST, PUT, DELETE, OPTIONS'];
              h['Access-Control-Allow-Headers'] = ['Content-Type, Authorization, Accept'];
            }),
          );
        }

        return result;
      };
    };
  }

  // Logging Middleware
  Middleware _loggingMiddleware() {
    return (Handler next) {
      return (Request request) async {
        final startTime = DateTime.now();
        print('→ ${request.method.name.toUpperCase()} ${request.url.path}');
        
        final result = await next(request);
        
        final duration = DateTime.now().difference(startTime);
        
        if (result is Response) {
          print('← ${result.statusCode} ${request.url.path} (${duration.inMilliseconds}ms)');
        }
        
        return result;
      };
    };
  }
}