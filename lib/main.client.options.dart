// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/client.dart';

import 'package:port/components/custom_cursor.dart' deferred as _custom_cursor;
import 'package:port/components/navigation.dart' deferred as _navigation;
import 'package:port/components/page_transition.dart'
    deferred as _page_transition;
import 'package:port/components/shimmer_image.dart' deferred as _shimmer_image;
import 'package:port/pages/admin/admin_dashboard.dart'
    deferred as _admin_dashboard;
import 'package:port/pages/admin/blog_admin.dart' deferred as _blog_admin;
import 'package:port/pages/admin/messages_admin.dart'
    deferred as _messages_admin;
import 'package:port/pages/admin/projects_admin.dart'
    deferred as _projects_admin;
import 'package:port/pages/archive_page.dart' deferred as _archive_page;
import 'package:port/pages/blog_page.dart' deferred as _blog_page;
import 'package:port/pages/blog_post_page.dart' deferred as _blog_post_page;
import 'package:port/pages/contact_page.dart' deferred as _contact_page;
import 'package:port/pages/home_page.dart' deferred as _home_page;
import 'package:port/pages/info_page.dart' deferred as _info_page;
import 'package:port/pages/project_detail_page.dart'
    deferred as _project_detail_page;

/// Default [ClientOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.client.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultClientOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ClientOptions get defaultClientOptions => ClientOptions(
  clients: {
    'custom_cursor': ClientLoader(
      (p) => _custom_cursor.CustomCursor(),
      loader: _custom_cursor.loadLibrary,
    ),
    'navigation': ClientLoader(
      (p) => _navigation.Navigation(),
      loader: _navigation.loadLibrary,
    ),
    'page_transition': ClientLoader(
      (p) => _page_transition.PageTransition(),
      loader: _page_transition.loadLibrary,
    ),
    'shimmer_image': ClientLoader(
      (p) => _shimmer_image.ShimmerImage(
        src: p['src'] as String,
        alt: p['alt'] as String,
        classes: p['classes'] as String,
      ),
      loader: _shimmer_image.loadLibrary,
    ),
    'admin_dashboard': ClientLoader(
      (p) => _admin_dashboard.AdminDashboard(),
      loader: _admin_dashboard.loadLibrary,
    ),
    'blog_admin': ClientLoader(
      (p) => _blog_admin.BlogAdmin(),
      loader: _blog_admin.loadLibrary,
    ),
    'messages_admin': ClientLoader(
      (p) => _messages_admin.MessagesAdmin(),
      loader: _messages_admin.loadLibrary,
    ),
    'projects_admin': ClientLoader(
      (p) => _projects_admin.ProjectsAdmin(),
      loader: _projects_admin.loadLibrary,
    ),
    'archive_page': ClientLoader(
      (p) => _archive_page.ArchivePage(),
      loader: _archive_page.loadLibrary,
    ),
    'blog_page': ClientLoader(
      (p) => _blog_page.BlogPage(),
      loader: _blog_page.loadLibrary,
    ),
    'blog_post_page': ClientLoader(
      (p) => _blog_post_page.BlogPostPage(slug: p['slug'] as String),
      loader: _blog_post_page.loadLibrary,
    ),
    'contact_page': ClientLoader(
      (p) => _contact_page.ContactPage(),
      loader: _contact_page.loadLibrary,
    ),
    'home_page': ClientLoader(
      (p) => _home_page.HomePage(),
      loader: _home_page.loadLibrary,
    ),
    'info_page': ClientLoader(
      (p) => _info_page.InfoPage(),
      loader: _info_page.loadLibrary,
    ),
    'project_detail_page': ClientLoader(
      (p) => _project_detail_page.ProjectDetailPage(
        projectId: p['projectId'] as String,
      ),
      loader: _project_detail_page.loadLibrary,
    ),
  },
);
