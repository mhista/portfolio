import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/project.dart';

class ProjectService {
  static const String baseUrl = 'http://localhost:8080'; // Your Serverpod URL

  static Future<List<Project>> getFeaturedProjects() async {
    return getMockProjects(); // Fallback to mock data
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

            /// MyCut — deals & multi-party transactions platform.
      /// Role: Technical Lead. Private — company-owned.
      Project(
        id: '9',
        title: 'MYCUT',
        description:
            'MyCut is a deals and structured multi-party transaction platform built at Grascope '
            'Technology, targeting deal hunters, bargain shoppers, and group-buy coordinators. '
            'As Technical Lead I led the Flutter mobile development and product architecture — '
            'including PRD, SRS, and system design — built on the Merkado OS infrastructure. '
            'The app benefits from cross-product intelligence: users who join from Driply arrive '
            'with their wallet, identity, and preferences already loaded.',
        category: 'DEALS PLATFORM / MOBILE APP — PROPRIETARY',
        imageUrl: 'https://ik.imagekit.io/esomchi/project/mycut/4.png', // TODO: replace
        year: '2025',
        order: 9,
        featured: true,
        isMobile: true,
        technologies: [
          'Flutter 3.x (iOS & Android)',
          'Bloc Pattern',
          'Merkado OS',
          'Multi-Party Payments',
          'Real-Time Sync',
          'Firebase',
        ],
        // Private app — placeholder store links; replace when published
        projectUrl:  [
          {
            'name': 'Play Store (Android)',
            'url': 'https://play.google.com/store/apps/details?id=com.grascope.mycut'
          },
          {
            'name': 'App Store (iOS)',
            'url': 'https://apps.apple.com/no/app/mycut/id6759074103'
          }
        ], // TODO: replace with real link
        images: [
          'https://ik.imagekit.io/esomchi/project/mycut/4.png',
          'https://ik.imagekit.io/esomchi/project/mycut/1.png',
          'https://ik.imagekit.io/esomchi/project/mycut/2.png',
          'https://ik.imagekit.io/esomchi/project/mycut/3.png',
        ],
        results: [
          '↑ Structured group-buy flows built on Merkado OS multi-party engine',
          '↑ Cross-product wallet: spend Driply balance on MyCut deals instantly',
          '↑ Personalized deals feed powered by shared recommendation engine',
        ],
      ),
      
      /// Driply — social commerce platform for African fashion.
      /// Role: Technical Lead. Rewrote entire codebase from scratch.
      /// Private — company-owned.
      Project(
        id: '8',
        title: 'DRIPLY',
        description:
            'Driply is a TikTok-style social commerce platform for African fashion built at Grascope '
            'Technology, where I served as Technical Lead. I rewrote the entire codebase from the '
            'ground up — architecting a Flutter 3.x mobile app (iOS & Android), a Next.js vendor '
            'dashboard, a video-first shoppable feed with HLS adaptive streaming via Bunny CDN, '
            'a two-sided creator marketplace for UGC, real-time collaborative live-closet sessions '
            'using Firebase Realtime DB, and a multi-gateway escrow payment system (Paystack + Fincra). '
            'The platform runs on the Merkado OS backbone, sharing identity, wallet, trust scoring, '
            'and notifications across Grascope\'s product suite.',
        category: 'SOCIAL COMMERCE / MOBILE & WEB — PROPRIETARY',
        imageUrl: 'https://ik.imagekit.io/esomchi/project/Driply/driply1.jpg', // TODO: replace
        year: '2025',
        order: 8,
        featured: true,
        isMobile: true,
        technologies: [
          'Flutter 3.x (iOS & Android)',
          'Next.js 14 + React',
          'Tailwind CSS + shadcn/ui',
          'HLS Video Streaming',
          'Bunny CDN',
          'Firebase Realtime DB',
          'Paystack + Fincra',
          'Metamap KYC',
          'Bloc Pattern',
          'Merkado OS',
          'FFmpeg',
          'Elasticsearch',
        ],
        // Private app — placeholder store links; replace when published
        projectUrl:  [
          {
            'name': 'Play Store (Android)',
            'url': 'https://play.google.com/store/apps/details?id=com.grascope.haulway.haulway'

          },
          {
            'name': 'App Store (iOS)',
            'url': 'https://apps.apple.com/ng/app/driply/id6636497539'
          }
        ], // TODO: replace with real link
        images: [
          'https://ik.imagekit.io/esomchi/project/Driply/driply1.jpg', // TODO: replace
          'https://ik.imagekit.io/esomchi/project/Driply/driply2.jpg',
          'https://ik.imagekit.io/esomchi/project/Driply/driply3.jpg',
          'https://ik.imagekit.io/esomchi/project/Driply/driply4.jpg',
          'https://ik.imagekit.io/esomchi/project/Driply/driply5.jpg',
        ],
        results: [
          '↑ Full codebase rewrite — zero legacy debt',
          '↑ Video-first feed with adaptive HLS streaming across all bandwidths',
          '↑ Escrow + KYC trust layer across buyer-vendor-creator triangle',
          '↑ Live collaborative shopping sessions with <200ms sync latency',
        ],
      ),

      // ──────────────────────────────────────────────
      // FEATURED / CLIENT WORK
      // ──────────────────────────────────────────────
      Project(
        id: '1',
        title: 'TURUCHI LAW FIRM',
        description:
            'A comprehensive legal services website specializing in personal injury, immigration law, '
            'workers\' compensation, and municipal matters. Features an elegant dark navy and orange '
            'color scheme with professional imagery and clear call-to-action elements.',
        category: 'WEB DEVELOPMENT / LEGAL',
        imageUrl: 'https://ik.imagekit.io/esomchi/project/turu/turu%20(1).png',
        year: '2025',
        order: 1,
        featured: true,
        technologies: [
          'NEXT JS',
          'Tailwind CSS',
          'Responsive Design',
          'UI/UX Design',
          'Branding',
        ],
        projectUrl: [
          {
            'name': 'Turuchi Law Firm',
            'url': 'https://turuchilawfirm.com'
          }
        ],
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
            'A comprehensive WAEC exam preparation platform featuring AI-powered feedback, real '
            'exam-style mock tests, personalized learning plans, progress analytics, and achievement '
            'tracking. The platform includes practice exams, quick drills, performance dashboards, '
            'and subject-specific breakdowns to help students ace their WAEC exams with confidence.',
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
        projectUrl: [
          {
            'name': 'PSKY Business School',
            'url': 'https://pskybusinessschool.com'
          }
        ],
        images: [
          'https://ik.imagekit.io/esomchi/project/psky/psky%20(7).png',
          'https://ik.imagekit.io/esomchi/project/psky/psky%20(8).png',
          'https://ik.imagekit.io/esomchi/project/psky/psky%20(2).png',
          'https://ik.imagekit.io/esomchi/project/psky/psky%20(3).png',
          'https://ik.imagekit.io/esomchi/project/psky/psky%20(4).png',
          'https://ik.imagekit.io/esomchi/project/psky/psky%20(5).png',
          'https://ik.imagekit.io/esomchi/project/psky/psky%20(6).png',
          'https://ik.imagekit.io/esomchi/project/psky/psky%20(1).png',
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
            'A modern interior design studio and furniture e-commerce platform featuring contemporary '
            'furniture collections, design services, and a blog. The website showcases products like '
            'Nordic chairs, Kruzo Aero chairs, and ergonomic furniture with a clean, minimalist '
            'aesthetic using earth tones and modern typography.',
        category: 'E-COMMERCE / WEB DESIGN',
        imageUrl: 'https://ik.imagekit.io/esomchi/project/furn/furn%20(1).png',
        year: '2023',
        order: 3,
        featured: true,
        projectUrl: [
          {
            'name': 'Live Site',
            'url': 'https://mhista.github.io/demo-design/'
          }
        ],
        technologies: [
          'HTML',
          'CSS',
          'E-commerce',
          'Responsive Design',
          'Modern UI/UX',
          'Content Management',
        ],
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

      // ──────────────────────────────────────────────
      // GRASCOPE TECHNOLOGY — TECHNICAL LEAD WORK
      // ──────────────────────────────────────────────

      /// Merkado OS — the multi-tenant infrastructure I architected that
      /// powers Driply, MyCut, ItsYourDay, FeastFeed, and Haulway.
      Project(
        id: '7',
        title: 'MERKADO OS',
        description:
            'Merkado OS is the digital economic operating system I architected at Grascope Technology — '
            'a multi-tenant, microservices-based backend platform that powers five distinct consumer '
            'products (Driply, MyCut, ItsYourDay, FeastFeed, Haulway) from a single unified '
            'infrastructure. The system delivers a shared identity layer (SSO), a cross-product wallet '
            'engine with escrow and multi-party splits, a behavioural trust-scoring engine, a real-time '
            'collaboration framework, AI-ready recommendation infrastructure, context-aware notification '
            'routing, and a modular asset-management pipeline — all accessible to tenant products via '
            'clean service contracts. Every new product on the platform launches in weeks rather than '
            'months because the core infrastructure already exists.',
        category: 'SYSTEM ARCHITECTURE / PLATFORM ENGINEERING',
        imageUrl: 'https://ik.imagekit.io/esomchi/project/Merkado/m1.jpg', // TODO: replace
        year: '2025',
        order: 7,
        featured: true,
        technologies: [
          'System Architecture',
          'Multi-Tenancy',
          'Microservices',
          'Kubernetes / Auto-Scaling',
          'PostgreSQL',
          'Redis',
          'Apache Kafka',
          'AWS',
          'Bunny CDN',
          'Elasticsearch',
          'Pinecone (Vector DB)',
          'Firebase Realtime DB',
          'Prometheus + Grafana',
          'Paystack / Fincra',
          'Metamap KYC',
        ],
        // No public URL — proprietary system
        projectUrl: [
          {
            'name': 'Github Repo (Light Demo Version)',
            'url': 'https://github.com/mhista/merkado_temp_repo'
          }
        ],
        images: [
          'https://ik.imagekit.io/esomchi/project/Merkado/m1.jpg', 
          'https://ik.imagekit.io/esomchi/project/Merkado/m2.png',
        ],
        results: [
          '↑ 5× product launch velocity — new products launch in weeks not months',
          '↑ Single identity + wallet across all Grascope products',
          '↑ Cross-product reputation & trust engine shared by all tenants',
          '↑ AI-ready infrastructure built in from Day 1',
        ],
      ),

      /// ItsYourDay — event planning & coordination platform.
      /// Role: Technical Lead. Private — company-owned.
      // Project(
      //   id: '10',
      //   title: 'ITSYOURDAY',
      //   description:
      //       'ItsYourDay is an event planning and coordination platform built at Grascope Technology '
      //       'for planning weddings, birthdays, and corporate events. As Technical Lead I directed '
      //       'Flutter mobile development and authored the full product architecture — PRD, SRS, and '
      //       'system design — on top of Merkado OS. The app leverages cross-product data: a user\'s '
      //       'fashion preferences from Driply instantly inform venue, décor, and caterer '
      //       'recommendations on ItsYourDay, making the first-time experience feel deeply personalised.',
      //   category: 'EVENT PLANNING / MOBILE APP — PROPRIETARY',
      //   imageUrl:
      //       'https://ik.imagekit.io/esomchi/project/itsyourday/iyd%20(1).png', // TODO: replace
      //   year: '2025',
      //   order: 10,
      //   featured: true,
      //   isMobile: true,
      //   technologies: [
      //     'Flutter 3.x (iOS & Android)',
      //     'Bloc Pattern',
      //     'Merkado OS',
      //     'Real-Time Collaboration',
      //     'Multi-Party Payments',
      //     'Firebase',
      //   ],
      //   // Private app — placeholder store links; replace when published
      //   projectUrl: 'https://play.google.com/store/apps', // TODO: replace with real link
      //   images: [
      //     'https://ik.imagekit.io/esomchi/project/itsyourday/iyd%20(1).png', // TODO: replace
      //   ],
      //   results: [
      //     '↑ Cross-product taste intelligence: fashion data informs event recommendations',
      //     '↑ Launched in 6 weeks reusing Merkado OS infrastructure',
      //     '↑ Collaborative budget + task management with role-based permissions',
      //   ],
      // ),

      // ──────────────────────────────────────────────
      // INDEPENDENT / RESEARCH PROJECTS
      // ──────────────────────────────────────────────
      Project(
        id: '4',
        title: 'ASAMI',
        description:
            'Nigeria\'s AI-powered business assistant that transforms customer interactions into '
            'exceptional commerce experiences. Asami is a conversational commerce platform operating '
            'on WhatsApp and Telegram — vendors manage their product catalogue through a Flutter '
            'mobile app using AI-assisted image recognition and NLP, while customers discover and '
            'purchase products through natural-language chat. Features deep localisation for Nigerian '
            'Pidgin and languages, automated order tracking, real-time crypto and fiat payment '
            'support, and a tiered subscription model. Currently awaiting deployment.',
        category: 'AI / SAAS PLATFORM — IN PROGRESS',
        imageUrl: 'https://ik.imagekit.io/esomchi/project/asami/asami%20(1).png',
        year: '2025',
        order: 4,
        featured: true,
        technologies: [
          'Flutter (Vendor App)',
          'Jaspr / Dart SSR (Landing)',
          'WhatsApp Business API',
          'Telegram Bot API',
          'OpenAI / Anthropic NLP',
          'Computer Vision (Product AI)',
          'Paystack + Crypto Gateways',
          'Firebase',
          'Node.js Microservices',
          'PostgreSQL',
        ],
        projectUrl: [
          {
            'name': 'Live Site',
            'url': 'https://asami-14a9a.web.app/'
          }
        ],
        images: [
          'https://ik.imagekit.io/esomchi/project/asami/asami%20(1).png',
          'https://ik.imagekit.io/esomchi/project/asami/asami%20(2).png',
          'https://ik.imagekit.io/esomchi/project/asami/asami%20(3).png',
          'https://ik.imagekit.io/esomchi/project/asami/asami%20(4).png',
          'https://ik.imagekit.io/esomchi/project/asami/asami%20(5).png',
          'https://ik.imagekit.io/esomchi/project/asami/asami%20(6).png',
        ],
        results: [
          '↑ <2 min product listing (vs. 10+ min manual entry)',
          '↑ Conversational shopping with >90% NLP intent accuracy',
          '↑ Unified fiat + crypto checkout inside messaging apps',
        ],
      ),

      // Project(
      //   id: '11',
      //   title: 'ENDOWE',
      //   description:
      //       'Endowe is an investment gift registry platform — users create registries for life '
      //       'milestones (graduation, wedding, baby shower) and guests invest real money in their '
      //       'future. I conducted a full technical audit of endowe.com, identified 7 security '
      //       'vulnerabilities (missing security headers, reverse tabnapping, no input sanitisation), '
      //       'critical SEO gaps, and a visual design that undersold the product. I rebuilt the site '
      //       'entirely in Jaspr (Dart SSR), delivering server-rendered HTML for full SEO indexability, '
      //       'a complete security header suite, structured JSON-LD data (FinancialService + FAQPage '
      //       'schemas), a reactive investment calculator, and a premium dark-forest-green identity '
      //       'with Cormorant Garamond typography.',
      //   category: 'WEB REDESIGN / FINTECH — FREELANCE',
      //   imageUrl:
      //       'https://ik.imagekit.io/esomchi/project/endowe/endowe%20(1).png', // TODO: replace
      //   year: '2025',
      //   order: 11,
      //   featured: true,
      //   technologies: [
      //     'Jaspr (Dart SSR)',
      //     'Dart HTTP Server',
      //     'SEO / JSON-LD Structured Data',
      //     'Security Headers (CSP, HSTS, XFO)',
      //     'PWA Manifest',
      //     'SMTP (Mailer Dart)',
      //     'Rate Limiting',
      //     'Tailwind CSS',
      //     'Cormorant Garamond',
      //   ],
      //   projectUrl: 'https://endowe.com', // TODO: confirm live URL
      //   images: [
      //     'https://ik.imagekit.io/esomchi/project/endowe/endowe%20(1).png', // TODO: replace
      //     'https://ik.imagekit.io/esomchi/project/endowe/endowe%20(2).png',
      //   ],
      //   results: [
      //     '↑ 7 security vulnerabilities resolved (0 remaining)',
      //     '↑ Lighthouse score ≥ 95 across all categories',
      //     '↑ Full SEO infrastructure: sitemap, canonical URLs, FinancialService schema',
      //     '↑ 150% increase in client inquiries post-launch',
      //   ],
      // ),

      // Project(
      //   id: '12',
      //   title: 'OFFLINEPAY',
      //   description:
      //       'OfflinePay is an ongoing research and development project to build Nigeria\'s first '
      //       'cryptographic peer-to-peer offline payment platform — enabling individuals and merchants '
      //       'to transact entirely without internet connectivity using only two smartphones. The protocol '
      //       'combines Ed25519 hardware-backed signing, AES-256-GCM encrypted QR/NFC transport, a '
      //       'gossip-layer settlement mechanism (epidemic algorithms), and a double-entry escrow ledger. '
      //       'Settlement is mathematically guaranteed to occur when either party reaches connectivity, '
      //       'with auto-settlement after 72 hours. The backend is a Serverpod 3.1.0 modular monolith '
      //       'on a full-Dart stack, with AI fraud scoring via Anthropic and AI ceiling calibration per '
      //       'user. Targeting CBN regulatory approval for Q1 2027 public launch.',
      //   category: 'FINTECH / RESEARCH — IN PROGRESS',
      //   imageUrl:
      //       'https://ik.imagekit.io/esomchi/project/offlinepay/op%20(1).png', // TODO: replace
      //   year: '2026',
      //   order: 12,
      //   featured: true,
      //   isMobile: true,
      //   technologies: [
      //     'Serverpod 3.1.0 (Dart Backend)',
      //     'Flutter (iOS & Android)',
      //     'Ed25519 Cryptography',
      //     'AES-256-GCM',
      //     'X25519 / libsodium',
      //     'Animated QR (HLS-style framing)',
      //     'NFC / Android HCE',
      //     'PostgreSQL (double-entry ledger)',
      //     'Redis',
      //     'Anthropic API (Fraud AI)',
      //     'Gossip / Epidemic Algorithms',
      //     'Bloom Filters',
      //     'Drift (SQLite ORM)',
      //   ],
      //   projectUrl: null, // research stage — no public URL yet
      //   images: [
      //     'https://ik.imagekit.io/esomchi/project/offlinepay/op%20(1).png', // TODO: replace
      //   ],
      //   results: [
      //     '↑ 100% offline operation — zero server round-trip at point of payment',
      //     '↑ Mathematically bounded fraud exposure: max loss = pre-funded ceiling',
      //     '↑ Gossip settlement layer: any third party reaching connectivity settles the chain',
      //     '↑ Full-Dart stack: shared cryptographic logic between server and Flutter app',
      //   ],
      // ),

      // ──────────────────────────────────────────────
      // ADDITIONAL PORTFOLIO WORK
      // ──────────────────────────────────────────────
      Project(
        id: '5',
        title: 'MEDICI',
        description:
            'A comprehensive AI-powered healthcare platform featuring intelligent medical assistance, '
            'doctor appointment booking, patient management, and real-time chat with healthcare '
            'professionals. Includes features like specialist search, pharmacy access, clinic finder, '
            'ambulance services, payment integration with multiple methods, and an AI health assistant '
            'for medical consultations.',
        category: 'HEALTHCARE / MOBILE APP',
        imageUrl: 'https://ik.imagekit.io/esomchi/project/medici/medici%20(3).jpg',
        year: '2024',
        order: 5,
        featured: true,
        isMobile: true,
        projectUrl: [
          {
            'name': 'App Demo',
            'url': 'https://drive.google.com/file/d/1D5FToZTf7l83AteZl-hdBCK14s_VFIOh/view?usp=drive_link'
          }
        ],
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
        title: 'PICKI',
        description:
            'A sleek multi-brand e-commerce mobile application featuring products from Nike, Adidas, '
            'IKEA, and Dell. The app offers a comprehensive shopping experience with featured brands, '
            'category browsing, product details with color and size selection, shopping cart management, '
            'promo codes, multiple payment methods including Paystack, and order tracking. '
            'Features a modern dark theme with orange accents.',
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
        projectUrl: [
          {
            'name': 'App Demo',
            'url': 'https://drive.google.com/file/d/1Q8n50HTU29DIFImBEtKD5JxeSHerGXCB/view?usp=sharing'
          }
        ],
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
