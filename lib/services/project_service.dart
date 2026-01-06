import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/project.dart';

class ProjectService {
  static const String baseUrl = 'http://localhost:8080'; // Your Serverpod URL

  static Future<List<Project>> getFeaturedProjects() async {
    return getMockProjects(); // Fallback to mock data

    // try {
    // final response = await http.get(
    //   Uri.parse('$baseUrl/projects/featured'),
    // );

    // if (response.statusCode == 200) {
    //   final List<dynamic> data = jsonDecode(response.body);
    //   return data.map((json) => Project.fromJson(json)).toList();
    // }

    // throw Exception('Failed to load projects');
    //   return _getMockProjects(); // Fallback to mock data
    // } catch (e) {
    //   print('Error fetching projects: $e');
    //   return _getMockProjects(); // Fallback to mock data
    // }
  }

  static Future<List<Project>> getAllProjects() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/projects'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Project.fromJson(json)).toList();
      }

      throw Exception('Failed to load projects');
    } catch (e) {
      print('Error fetching projects: $e');
      return getMockProjects();
    }
  }

  static List<Project> getMockProjects() {
    return [
      Project(
        id: '1',
        title: 'TURUCHI LAW FIRM',
        description:
            'A comprehensive legal services website specializing in personal injury, immigration law, workers\' compensation, and municipal matters. Features an elegant dark navy and orange color scheme with professional imagery and clear call-to-action elements.',
        category: 'WEB DEVELOPMENT / LEGAL',
        imageUrl: 'https://ik.imagekit.io/esomchi/project/turu/turu%20(1).png',
        year: '2025',
        order: 1,
        featured: true,
        technologies: ['NEXT JS', 'Tailwind CSS', 'Responsive Design', 'UI/UX Design', 'Branding'],
        projectUrl: 'https://turuchilawfirm.com',
        images: [
          'https://ik.imagekit.io/esomchi/project/turu/turu%20(1).png',
          'https://ik.imagekit.io/esomchi/project/turu/turu%20(2).png',
          'https://ik.imagekit.io/esomchi/project/turu/turu%20(3).png',
          'https://ik.imagekit.io/esomchi/project/turu/turu%20(4).png',
          
        ],
        results: [
          '↑ 150% increase in client inquiries',
          '↑ 200% faster page load times',
          '↑ 95% positive client feedback',
        ],
      ),
      Project(
        id: '2',
        title: 'PSKY BUSINESS SCHOOL',
        description:
            'A comprehensive WAEC exam preparation platform featuring AI-powered feedback, real exam-style mock tests, personalized learning plans, progress analytics, and achievement tracking. The platform includes practice exams, quick drills, performance dashboards, and subject-specific breakdowns to help students ace their WAEC exams with confidence.',
        category: 'EDTECH / WEB & MOBILE APP',
        imageUrl: 'https://ik.imagekit.io/esomchi/project/psky/psky%20(7).png',
        year: '2025',
        order: 2,
        featured: true,
        technologies: [
          'Flutter',
          'Flutter Web',
          'Firebase',
          'AI Integration',
          'Responsive Design',
          'Analytics Dashboard',
        ],
        projectUrl: 'https://pskybusinessschool.com',
        images: [
          'https://ik.imagekit.io/esomchi/project/psky/psky%20(7).png',
          'https://ik.imagekit.io/esomchi/project/psky/psky%20(8).png',
          'https://ik.imagekit.io/esomchi/project/psky/psky%20(2).png',
          'https://ik.imagekit.io/esomchi/project/psky/psky%20(3).png',
          'https://ik.imagekit.io/esomchi/project/psky/psky%20(4).png', 
          'https://ik.imagekit.io/esomchi/project/psky/psky%20(5).png',
          'https://ik.imagekit.io/esomchi/project/psky/psky%20(6).png',
          'https://ik.imagekit.io/esomchi/project/psky/psky%20(1).png'
        ],
        results: [
          '↑ 300% increase in student engagement',
          '↑ 85% exam success rate improvement',
          '↑ 98% user satisfaction rating',
        ],
      ),
      Project(
        id: '3',
        title: 'FURNI',
        description:
            'A modern interior design studio and furniture e-commerce platform featuring contemporary furniture collections, design services, and a blog. The website showcases products like Nordic chairs, Kruzo Aero chairs, and ergonomic furniture with a clean, minimalist aesthetic using earth tones and modern typography.',
        category: 'E-COMMERCE / WEB DESIGN',
        imageUrl: 'https://ik.imagekit.io/esomchi/project/furn/furn%20(1).png',
        year: '2023',
        order: 3,
        featured: true,
        projectUrl: 'https://mhista.github.io/demo-design/',
        technologies: ['HTML', 'CSS', 'E-commerce', 'Responsive Design', 'Modern UI/UX', 'Content Management'],
        images: [
          'https://ik.imagekit.io/esomchi/project/furn/furn%20(1).png',
          'https://ik.imagekit.io/esomchi/project/furn/furn%20(2).png',
          'https://ik.imagekit.io/esomchi/project/furn/furn%20(3).png',
          'https://ik.imagekit.io/esomchi/project/furn/furn%20(4).png',
          'https://ik.imagekit.io/esomchi/project/furn/furn%20(5).png',
        ],
        results: [
          '↑ 180% increase in online sales',
          '↑ 220% faster checkout process',
          '↑ 92% customer satisfaction score',
        ],
      ),
      Project(
        id: '4',
        title: 'ASAMI',
        description:
            'Nigeria\'s smartest AI-powered business assistant that transforms customer interactions into exceptional experiences. Features intelligent product discovery, deep localized context with NLP for Nigerian languages and pidgin, automated order tracking and fulfillment, WhatsApp and Telegram integration, and complete messaging solutions for businesses.',
        category: 'AI / SAAS PLATFORM',
          imageUrl: 'https://ik.imagekit.io/esomchi/project/asami/asami%20(1).png',
        year: '2025',
        order: 4,
        featured: true,
        technologies: [
          'AI/ML',
          'NLP',
          'WhatsApp API',
          'Telegram Bot',
          'Flutter Web',
          'Real-time Chat',
          'Voice Processing',
        ],
        projectUrl: 'https://asami-14a9a.web.app/',
        images: [
          'https://ik.imagekit.io/esomchi/project/asami/asami%20(1).png',
          'https://ik.imagekit.io/esomchi/project/asami/asami%20(2).png',
          'https://ik.imagekit.io/esomchi/project/asami/asami%20(3).png',
          'https://ik.imagekit.io/esomchi/project/asami/asami%20(4).png',
          'https://ik.imagekit.io/esomchi/project/asami/asami%20(5).png',
          'https://ik.imagekit.io/esomchi/project/asami/asami%20(6).png',
        ],
        results: [
          '↑ 250% increase in customer response rate',
          '↑ 400% reduction in support costs',
          '↑ 96% positive business feedback',
        ],
      ),
      Project(
        id: '5',
        title: 'MEDICI',
        description:
            'A comprehensive AI-powered healthcare platform featuring intelligent medical assistance, doctor appointment booking, patient management, and real-time chat with healthcare professionals. Includes features like specialist search, pharmacy access, clinic finder, ambulance services, payment integration with multiple methods, and an AI health assistant for medical consultations.',
        category: 'HEALTHCARE / MOBILE APP',
        imageUrl: 'https://ik.imagekit.io/esomchi/project/medici/medici%20(3).jpg',
        year: '2024',
        order: 5,
        featured: true,
        isMobile: true,
        projectUrl: 'https://drive.google.com/file/d/1D5FToZTf7l83AteZl-hdBCK14s_VFIOh/view?usp=drive_link',
        technologies: [
          'Flutter',
          'AI/ML',
          'Payment Integration',
          'Real-time Chat',
          'Maps API',
          'Firebase',
          'Healthcare APIs',
        ],
        images: [
          
          'https://ik.imagekit.io/esomchi/project/medici/medici%20(8).jpg',
          'https://ik.imagekit.io/esomchi/project/medici/medici%20(3).jpg',
          'https://ik.imagekit.io/esomchi/project/medici/medici%20(1).jpg',
          'https://ik.imagekit.io/esomchi/project/medici/medici%20(2).jpg',
          'https://ik.imagekit.io/esomchi/project/medici/medici%20(4).jpg',
          'https://ik.imagekit.io/esomchi/project/medici/medici%20(5).jpg',
          'https://ik.imagekit.io/esomchi/project/medici/medici%20(6).jpg',
          'https://ik.imagekit.io/esomchi/project/medici/medici%20(7).jpg',
          'https://ik.imagekit.io/esomchi/project/medici/medici%20(8).jpg',
          'https://ik.imagekit.io/esomchi/project/medici/medici%20(9).jpg',
          'https://ik.imagekit.io/esomchi/project/medici/medici%20(10).jpg',
          'https://ik.imagekit.io/esomchi/project/medici/medici%20(11).jpg',
          'https://ik.imagekit.io/esomchi/project/medici/medici%20(12).jpg',
        ],
        results: [
          '↑ 280% increase in appointment bookings',
          '↑ 350% faster patient registration',
          '↑ 94% user satisfaction rating',
        ],
      ),
      Project(
        id: '6',
        title: 'Picki',
        description:
            'A sleek multi-brand e-commerce mobile application featuring products from Nike, Adidas, IKEA, and Dell. The app offers a comprehensive shopping experience with featured brands, category browsing (Sports, Jewelry, Electronics, Clothing, Animals), product details with color and size selection, shopping cart management, promo codes, multiple payment methods including Paystack, and order tracking. Features a modern dark theme with orange accents.',
        category: 'E-COMMERCE / MOBILE APP',
        imageUrl: 'https://ik.imagekit.io/esomchi/project/picki/picki%20(4).jpg',
        year: '2024',
        order: 6,
        featured: true,
        isMobile: true,
        technologies: [
          'Flutter',
          'Paystack Integration',
          'Cart Management',
          'Product Filtering',
          'Firebase',
          'Payment Gateway',
        ],
        projectUrl: 'https://drive.google.com/file/d/1Q8n50HTU29DIFImBEtKD5JxeSHerGXCB/view?usp=sharing',
        images: [
          'https://ik.imagekit.io/esomchi/project/picki/picki%20(1).jpg',
          'https://ik.imagekit.io/esomchi/project/picki/picki%20(2).jpg',
          'https://ik.imagekit.io/esomchi/project/picki/picki%20(3).jpg',
          'https://ik.imagekit.io/esomchi/project/picki/picki%20(4).jpg',
          'https://ik.imagekit.io/esomchi/project/picki/picki%20(5).jpg',
          'https://ik.imagekit.io/esomchi/project/picki/picki%20(6).jpg',
          'https://ik.imagekit.io/esomchi/project/picki/picki%20(7).jpg',
          'https://ik.imagekit.io/esomchi/project/picki/picki%20(8).jpg',
          'https://ik.imagekit.io/esomchi/project/picki/picki%20(9).jpg',
          'https://ik.imagekit.io/esomchi/project/picki/picki%20(10).jpg',
          'https://ik.imagekit.io/esomchi/project/picki/picki%20(11).jpg',
        ],
        results: [
          '↑ 320% increase in mobile sales',
          '↑ 180% improvement in cart conversion',
          '↑ 91% customer satisfaction score',
        ],
      ),
    ];
  }
}
