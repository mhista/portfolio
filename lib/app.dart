import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

// Pages
import '../main_layout.dart';
import '../pages/admin/admin_dashboard.dart';
import '../pages/admin/blog_admin.dart';
import '../pages/admin/messages_admin.dart';
import '../pages/admin/projects_admin.dart';
import '../pages/archive_page.dart';
import '../pages/blog_page.dart';
import '../pages/blog_post_page.dart';
import '../pages/contact_page.dart';
import '../pages/home_page.dart';
import '../pages/info_page.dart';
import '../pages/project_detail_page.dart';


// Admin Pages


// Layout

class App extends StatelessComponent {
  @override
  Component build(BuildContext context)  {
    return Router(
      routes: [
        // Public Routes
        Route(
          path: '/app',
          builder: (context, state) => MainLayout(child: HomePage()),
        ),
        Route(
          path: '/app/archive',
          builder: (context, state) => MainLayout(child: ArchivePage()),
        ),
        Route(
          path: '/app/info',
          builder: (context, state) => MainLayout(child: InfoPage()),
        ),
        Route(
          path: '/app/contact',
          builder: (context, state) => MainLayout(child: ContactPage()),
        ),
        Route(
          path: '/app/projects/:id',
          builder: (context, state) {
            final id = state.params['id']!;
            return MainLayout(child: ProjectDetailPage(projectId: id));
          },
        ),
        Route(
          path: '/app/blog',
          builder: (context, state) => MainLayout(child: BlogPage()),
        ),
        // Route(
        //   path: '/blog/:slug',
        //   builder: (context, state) {
        //     final slug = state.params['slug']!;
        //     return MainLayout(child: BlogPostPage(slug: slug));
        //   },
        // ),

        // Admin Routes
        // Route(
        //   path: '/admin',
        //   builder: (context, state) => AdminDashboard(),
        // ),
        // Route(
        //   path: '/admin/dashboard',
        //   builder: (context, state) => AdminDashboard(),
        // ),
        // Route(
        //   path: '/admin/projects',
        //   builder: (context, state) => ProjectsAdmin(),
        // ),
        // Route(
        //   path: '/admin/blog',
        //   builder: (context, state) => BlogAdmin(),
        // ),
        // Route(
        //   path: '/admin/messages',
        //   builder: (context, state) => MessagesAdmin(),
        // ),
      ],
    );
  }
}