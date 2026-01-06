// import 'dart:convert';
// import 'dart:io';
// import 'package:jaspr/server.dart';
// import 'package:relic/relic.dart';
// import 'package:relic/io_adapter.dart';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server.dart';

// // Import your App component
// import '../app.dart';
// import '../services/project_service.dart';

// class EmailServer {
//   static final String smtpHost = Platform.environment['SMTP_HOST'] ?? 'smtp.gmail.com';
//   static final int smtpPort = Platform.environment['SMTP_PORT'] != null
//       ? int.parse(Platform.environment['SMTP_PORT']!)
//       : 587;
//   static final String smtpUser = Platform.environment['SMTP_USER'] ?? 'your-email@gmail.com';
//   static final String smtpPassword = Platform.environment['SMTP_PASSWORD'] ?? 'your-app-password';
//   static final String receiverEmail = Platform.environment['RECEIVER_EMAIL'] ?? 'your-email@gmail.com';

//   Future<void> start() async {
//     final router = Router();

//     // Health check
//     router.get('/health', (Request request) {
//       return Response.ok('Server is running');
//     });

//     // Contact form endpoint
//     router.post('/contact/send', _handleContactForm);

//     // API Endpoints
//     // router.get('/api/projects/featured', (Request request) async {
//     //   final projects = ProjectService.getMockProjects().where((p) => p.featured).toList();

//     //   return Response.ok(
//     //     jsonEncode(projects.map((p) => p.toJson()).toList()),
//     //     headers: {
//     //       'Content-Type': 'application/json',
//     //       ..._corsHeaders,
//     //     },
//     //   );
//     // });

//     // router.get('/api/projects', (Request request) async {
//     //   final projects = ProjectService.getMockProjects();

//     //   return Response.ok(
//     //     jsonEncode(projects.map((p) => p.toJson()).toList()),
//     //     headers: {
//     //       'Content-Type': 'application/json',
//     //       ..._corsHeaders,
//     //     },
//     //   );
//     // });

//     // router.get('/api/projects/<id>', (Request request, String id) async {
//     //   try {
//     //     final projects = ProjectService.getMockProjects();
//     //     final project = projects.firstWhere((p) => p.id == id);

//     //     return Response.ok(
//     //       jsonEncode(project.toJson()),
//     //       headers: {
//     //         'Content-Type': 'application/json',
//     //         ..._corsHeaders,
//     //       },
//     //     );
//     //   } catch (e) {
//     //     return Response.notFound(
//     //       jsonEncode({'error': 'Project not found'}),
//     //       headers: {'Content-Type': 'application/json'},
//     //     );
//     //   }
//     // });

//     // HTML Routes - Render each page explicitly
//     // router.get('/', (request) async {
//     //   return Response.ok(
//     //     await renderComponent(
//     //       Document(
//     //         title: 'Portfolio - Home',
//     //         head: [
//     //           meta(charset: 'utf-8'),
//     //           meta(name: 'viewport', content: 'width=device-width, initial-scale=1.0'),
//     //           link(rel: 'stylesheet', href: '/main.css'),
//     //           link(rel: 'stylesheet', href: '/styles.css'),
//     //           script(src: '/interaction.js'),
//     //           script(src: 'https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js'),
//     //           script(src: 'https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollTrigger.min.js'),
//     //         ],
//     //         body: MainLayout(child: HomePage()),
//     //       ),
//     //     ),
//     //     headers: {'Content-Type': 'text/html'},
//     //   );
//     // });

//     // router.get('/info', (request) async {
//     //   return Response.ok(
//     //     await renderComponent(
//     //       Document(
//     //         title: 'Portfolio - Info',
//     //         head: [
//     //           meta(charset: 'utf-8'),
//     //           meta(name: 'viewport', content: 'width=device-width, initial-scale=1.0'),
//     //           link(rel: 'stylesheet', href: '/main.css'),
//     //           link(rel: 'stylesheet', href: '/styles.css'),
//     //           script(src: '/interaction.js'),
//     //           script(src: 'https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js'),
//     //           script(src: 'https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollTrigger.min.js'),
//     //         ],
//     //         body: MainLayout(child: InfoPage()),
//     //       ),
//     //     ),
//     //     headers: {'Content-Type': 'text/html'},
//     //   );
//     // });

//     // router.get('/contact', (request) async {
//     //   return Response.ok(
//     //     await renderComponent(
//     //       Document(
//     //         title: 'Portfolio - Contact',
//     //         head: [
//     //           meta(charset: 'utf-8'),
//     //           meta(name: 'viewport', content: 'width=device-width, initial-scale=1.0'),
//     //           link(rel: 'stylesheet', href: '/main.css'),
//     //           link(rel: 'stylesheet', href: '/styles.css'),
//     //           script(src: '/interaction.js', ),
//     //           script(src: 'https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js'),
//     //           script(src: 'https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollTrigger.min.js'),
//     //         ],
//     //         body: MainLayout(child: ContactPage()),
//     //       ),
//     //     ),
//     //     headers: {'Content-Type': 'text/html'},
//     //   );
//     // });

//     // router.get('/archive', (request) async {
//     //   return Response.ok(
//     //     await renderComponent(
//     //       Document(
//     //         title: 'Portfolio - Archive',
//     //         head: [
//     //           meta(charset: 'utf-8'),
//     //           meta(name: 'viewport', content: 'width=device-width, initial-scale=1.0'),
//     //           link(rel: 'stylesheet', href: '/main.css'),
//     //           link(rel: 'stylesheet', href: '/styles.css'),
//     //           script(src: '/interaction.js', ),
//     //           script(src: 'https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js'),
//     //           script(src: 'https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollTrigger.min.js'),
//     //         ],
//     //         body: MainLayout(child: ArchivePage()),
//     //       ),
//     //     ),
//     //     headers: {'Content-Type': 'text/html'},
//     //   );
//     // });

//     // router.get('/blog', (request) async {
//     //   return Response.ok(
//     //     await renderComponent(
//     //       Document(
//     //         title: 'Portfolio - Blog',
//     //         head: [
//     //           meta(charset: 'utf-8'),
//     //           meta(name: 'viewport', content: 'width=device-width, initial-scale=1.0'),
//     //           link(rel: 'stylesheet', href: '/main.css'),
//     //           link(rel: 'stylesheet', href: '/styles.css'),
//     //           script(src: '/interaction.js', ),
//     //           script(src: 'https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js'),
//     //           script(src: 'https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollTrigger.min.js'),
//     //         ],
//     //         body: MainLayout(child: BlogPage()),
//     //       ),
//     //     ),
//     //     headers: {'Content-Type': 'text/html'},
//     //   );
//     // });

//     // router.get('/projects/<id>', (request, String id) async {
//     //   return Response.ok(
//     //     await renderComponent(
//     //       Document(
//     //         title: 'Portfolio - Project',
//     //         head: [
//     //           meta(charset: 'utf-8'),
//     //           meta(name: 'viewport', content: 'width=device-width, initial-scale=1.0'),
//     //           link(rel: 'stylesheet', href: '/main.css'),
//     //           link(rel: 'stylesheet', href: '/styles.css'),
//     //           script(src: '/interaction.js'),
//     //           script(src: 'https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js'),
//     //           script(src: 'https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollTrigger.min.js'),
//     //         ],
//     //         body: MainLayout(child: ProjectDetailPage(projectId: id)),
//     //       ),
//     //     ),
//     //     headers: {'Content-Type': 'text/html'},
//     //   );
//     // });

//     // // Mount static file serving LAST (catch-all for CSS, JS, images)
//     // router.mount(
//     //   '/app',
//     //   serveApp((request, render) {
//     //     print("Serving: ${request.url}");

//     //     // Return the App with Router
//     //     return render(
//     //       Document(
//     //         title: 'port',
//     //         base: '/app',
//     //         head: [
//     //           meta(charset: 'utf-8'),
//     //           meta(name: 'viewport', content: 'width=device-width, initial-scale=1.0'),
//     //           link(rel: 'stylesheet', href: '/main.css'),

//     //           // link(rel: 'stylesheet', href: '/styles.tw.css'),
//     //           script(
//     //             src: '/interaction.js',
//     //           ),
//     //           script(
//     //             src: 'https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4',
//     //           ),
//     //           script(
//     //             src: 'https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js',
//     //           ),
//     //           script(
//     //             src: 'https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollTrigger.min.js',
//     //           ),
//     //         ],
//     //         styles: [
//     //           // Special import rule to include to another css file.
//     //           css.import('https://fonts.googleapis.com/css?family=Roboto'),
//     //           // Each style rule takes a valid css selector and a set of styles.

//     //           // Styles are defined using type-safe css bindings and can be freely chained and nested.
//     //           css('html, body').styles(
//     //             width: 100.percent,
//     //             minHeight: 100.vh,
//     //             padding: .zero,
//     //             margin: .zero,
//     //             fontFamily: const .list([FontFamily('Roboto'), FontFamilies.sansSerif]),
//     //           ),
//     //           css('h1').styles(
//     //             margin: .unset,
//     //             fontSize: 4.rem,
//     //           ),
//     //         ],
//     //         body: App(),
//     //       ),
//     //     );
//     //   }),
//     // );

//     final handler = Pipeline().addMiddleware(_corsMiddleware()).addMiddleware(logRequests()).addHandler(router.call);

//     final server = await shelf_io.serve(handler, '0.0.0.0', 8080, shared: true);
//     server.autoCompress = true;
//     print('✅ Server running on http://${server.address.host}:${server.port}');
//     print('📧 Email endpoint: http://${server.address.host}:${server.port}/contact/send');
//     print('📦 API endpoints: http://${server.address.host}:${server.port}/api/projects');
//   }

//   Future<Response> _handleContactForm(Request request) async {
//     try {
//       final body = await request.readAsString();
//       final data = jsonDecode(body) as Map<String, dynamic>;

//       final name = data['name'] as String?;
//       final email = data['email'] as String?;
//       final subject = data['subject'] as String?;
//       final message = data['message'] as String?;

//       if (name == null || name.isEmpty || email == null || email.isEmpty || message == null || message.isEmpty) {
//         return Response(400, body: jsonEncode({'success': false, 'error': 'Missing required fields'}));
//       }

//       final success = await _sendEmail(
//         name: name,
//         email: email,
//         subject: subject ?? 'Contact Form Submission',
//         message: message,
//       );

//       if (success) {
//         return Response.ok(jsonEncode({'success': true, 'message': 'Email sent successfully'}));
//       } else {
//         return Response(500, body: jsonEncode({'success': false, 'error': 'Failed to send email'}));
//       }
//     } catch (e) {
//       print('Error handling contact form: $e');
//       return Response(500, body: jsonEncode({'success': false, 'error': 'Server error: $e'}));
//     }
//   }

//   Future<bool> _sendEmail({
//     required String name,
//     required String email,
//     required String subject,
//     required String message,
//   }) async {
//     try {
//       final smtpServer = gmail(smtpUser, smtpPassword);

//       final emailMessage = Message()
//         ..from = Address(smtpUser, 'Portfolio Contact Form')
//         ..recipients.add(receiverEmail)
//         ..subject = '📧 Portfolio Contact: $subject'
//         ..html = _buildEmailTemplate(
//           name: name,
//           email: email,
//           subject: subject,
//           message: message,
//         );

//       final sendReport = await send(emailMessage, smtpServer);
//       print('✅ Email sent: ${sendReport.toString()}');
//       return true;
//     } catch (e) {
//       print('❌ Failed to send email: $e');
//       return false;
//     }
//   }

//   String _buildEmailTemplate({
//     required String name,
//     required String email,
//     required String subject,
//     required String message,
//   }) {
//     return '''
// <!DOCTYPE html>
// <html>
// <head>
//   <style>
//     body { 
//       font-family: 'SF Mono', monospace; 
//       line-height: 1.6; 
//       color: #f5f5f5;
//       background: #0a0a0a;
//       margin: 0;
//       padding: 0;
//     }
//     .container { 
//       max-width: 600px; 
//       margin: 0 auto; 
//       padding: 20px; 
//     }
//     .header { 
//       background: #00ff41; 
//       color: #0a0a0a; 
//       padding: 30px 20px; 
//       text-align: center;
//       border-radius: 8px 8px 0 0;
//     }
//     .header h1 {
//       margin: 0;
//       font-size: 24px;
//       text-transform: uppercase;
//       letter-spacing: 2px;
//     }
//     .content { 
//       background: #111; 
//       padding: 30px; 
//       border-radius: 0 0 8px 8px;
//     }
//     .field { 
//       margin-bottom: 20px;
//       padding: 15px;
//       background: #0a0a0a;
//       border-left: 3px solid #00ff41;
//       border-radius: 4px;
//     }
//     .field-label { 
//       font-size: 11px; 
//       color: #666; 
//       text-transform: uppercase; 
//       letter-spacing: 1px;
//       margin-bottom: 8px;
//     }
//     .field-value { 
//       font-size: 14px; 
//       color: #f5f5f5;
//       word-wrap: break-word;
//     }
//     .message-box {
//       background: #0a0a0a;
//       padding: 20px;
//       border-radius: 4px;
//       white-space: pre-wrap;
//       line-height: 1.8;
//     }
//     .footer { 
//       text-align: center; 
//       padding: 20px; 
//       font-size: 12px; 
//       color: #666; 
//     }
//     .reply-button {
//       display: inline-block;
//       background: #00ff41;
//       color: #0a0a0a;
//       padding: 12px 30px;
//       text-decoration: none;
//       border-radius: 4px;
//       font-weight: bold;
//       text-transform: uppercase;
//       letter-spacing: 1px;
//       margin: 20px 0;
//     }
//   </style>
// </head>
// <body>
//   <div class="container">
//     <div class="header">
//       <h1>📧 New Contact Message</h1>
//     </div>
//     <div class="content">
//       <div class="field">
//         <div class="field-label">From</div>
//         <div class="field-value">$name</div>
//       </div>
      
//       <div class="field">
//         <div class="field-label">Email</div>
//         <div class="field-value">
//           <a href="mailto:$email" style="color: #00ff41; text-decoration: none;">$email</a>
//         </div>
//       </div>
      
//       <div class="field">
//         <div class="field-label">Subject</div>
//         <div class="field-value">$subject</div>
//       </div>
      
//       <div class="field">
//         <div class="field-label">Message</div>
//         <div class="field-value">
//           <div class="message-box">$message</div>
//         </div>
//       </div>
      
//       <center>
//         <a href="mailto:$email?subject=Re: $subject" class="reply-button">
//           Reply to $name
//         </a>
//       </center>
//     </div>
//     <div class="footer">
//       <p>Sent from your portfolio contact form</p>
//       <p>© ${DateTime.now().year} Portfolio. Powered by Dart + Shelf</p>
//     </div>
//   </div>
// </body>
// </html>
//     ''';
//   }

//   Middleware _corsMiddleware() {
//     return (Handler handler) {
//       return (Request request) async {
//         if (request.method == 'OPTIONS') {
//           return Response.ok('', headers: _corsHeaders);
//         }

//         final response = await handler(request);
//         return response.change(headers: _corsHeaders);
//       };
//     };
//   }

//   Map<String, String> get _corsHeaders => {
//     'Access-Control-Allow-Origin': '*',
//     'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
//     'Access-Control-Allow-Headers': 'Content-Type, Authorization',
//     'Content-Type': 'application/json',
//   };
// }
