import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class EmailService {
  // Use localhost for development, your domain for production
  static final String baseUrl = Platform.environment['BASE_URL'] ?? 'http://localhost:8080';
  // For production: static const String baseUrl = 'https://api.yourdomain.com';

  static Future<bool> sendContactEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    try {
      print('📧 Sending email to: $baseUrl/contact/send');
      final response = await http.post(
        Uri.parse('$baseUrl/contact/send'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'subject': subject,
          'message': message,
        }),
      );

      print('📧 Response status: ${response.statusCode}');
      print('📧 Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'] == true;
      }

      return false;
    } catch (e) {
      print('Error sending email: $e');
      return false;
    }
  }
}
