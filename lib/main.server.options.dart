// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:port/components/custom_cursor.dart' as _custom_cursor;
import 'package:port/components/navigation.dart' as _navigation;
import 'package:port/components/page_transition.dart' as _page_transition;
import 'package:port/components/shimmer_image.dart' as _shimmer_image;
import 'package:port/pages/admin/admin_dashboard.dart' as _admin_dashboard;
import 'package:port/pages/admin/blog_admin.dart' as _blog_admin;
import 'package:port/pages/admin/messages_admin.dart' as _messages_admin;
import 'package:port/pages/admin/projects_admin.dart' as _projects_admin;
import 'package:port/pages/archive_page.dart' as _archive_page;
import 'package:port/pages/blog_page.dart' as _blog_page;
import 'package:port/pages/blog_post_page.dart' as _blog_post_page;
import 'package:port/pages/contact_page.dart' as _contact_page;
import 'package:port/pages/home_page.dart' as _home_page;
import 'package:port/pages/info_page.dart' as _info_page;
import 'package:port/pages/project_detail_page.dart' as _project_detail_page;

/// Default [ServerOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.server.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultServerOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ServerOptions get defaultServerOptions => ServerOptions(
  clientId: 'main.client.dart.js',
  clients: {
    _custom_cursor.CustomCursor: ClientTarget<_custom_cursor.CustomCursor>(
      'custom_cursor',
    ),
    _navigation.Navigation: ClientTarget<_navigation.Navigation>('navigation'),
    _page_transition.PageTransition:
        ClientTarget<_page_transition.PageTransition>('page_transition'),
    _shimmer_image.ShimmerImage: ClientTarget<_shimmer_image.ShimmerImage>(
      'shimmer_image',
      params: __shimmer_imageShimmerImage,
    ),
    _admin_dashboard.AdminDashboard:
        ClientTarget<_admin_dashboard.AdminDashboard>('admin_dashboard'),
    _blog_admin.BlogAdmin: ClientTarget<_blog_admin.BlogAdmin>('blog_admin'),
    _messages_admin.MessagesAdmin: ClientTarget<_messages_admin.MessagesAdmin>(
      'messages_admin',
    ),
    _projects_admin.ProjectsAdmin: ClientTarget<_projects_admin.ProjectsAdmin>(
      'projects_admin',
    ),
    _archive_page.ArchivePage: ClientTarget<_archive_page.ArchivePage>(
      'archive_page',
    ),
    _blog_page.BlogPage: ClientTarget<_blog_page.BlogPage>('blog_page'),
    _blog_post_page.BlogPostPage: ClientTarget<_blog_post_page.BlogPostPage>(
      'blog_post_page',
      params: __blog_post_pageBlogPostPage,
    ),
    _contact_page.ContactPage: ClientTarget<_contact_page.ContactPage>(
      'contact_page',
    ),
    _home_page.HomePage: ClientTarget<_home_page.HomePage>('home_page'),
    _info_page.InfoPage: ClientTarget<_info_page.InfoPage>('info_page'),
    _project_detail_page.ProjectDetailPage:
        ClientTarget<_project_detail_page.ProjectDetailPage>(
          'project_detail_page',
          params: __project_detail_pageProjectDetailPage,
        ),
  },
);

Map<String, Object?> __shimmer_imageShimmerImage(
  _shimmer_image.ShimmerImage c,
) => {'src': c.src, 'alt': c.alt, 'classes': c.classes};
Map<String, Object?> __blog_post_pageBlogPostPage(
  _blog_post_page.BlogPostPage c,
) => {'slug': c.slug};
Map<String, Object?> __project_detail_pageProjectDetailPage(
  _project_detail_page.ProjectDetailPage c,
) => {'projectId': c.projectId};
