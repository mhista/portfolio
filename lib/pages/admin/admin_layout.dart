import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class AdminLayout extends StatelessComponent {
  final Component child;

  const AdminLayout({required this.child});

  @override
  Component build(BuildContext context) {
    return div(classes: 'admin-layout', [
      div(classes: 'admin-sidebar', [
        h2(classes: 'admin-logo scramble-text', attributes: {'data-text': 'ADMIN'}, [
          Component.text('ADMIN'),
        ]),
        nav(classes: 'admin-nav', [
          ul([
            li([
              a(
                href: '/admin/dashboard',
                classes: 'admin-nav-link scramble-text magnetic',
                attributes: {'data-text': 'DASHBOARD', 'data-strength': '15'},
                [Component.text('DASHBOARD')],
              ),
            ]),
            li([
              a(
                href: '/admin/projects',
                classes: 'admin-nav-link scramble-text magnetic',
                attributes: {'data-text': 'PROJECTS', 'data-strength': '15'},
                [Component.text('PROJECTS')],
              ),
            ]),
            li([
              a(
                href: '/admin/blog',
                classes: 'admin-nav-link scramble-text magnetic',
                attributes: {'data-text': 'BLOG', 'data-strength': '15'},
                [Component.text('BLOG')],
              ),
            ]),
            li([
              a(
                href: '/admin/messages',
                classes: 'admin-nav-link scramble-text magnetic',
                attributes: {'data-text': 'MESSAGES', 'data-strength': '15'},
                [Component.text('MESSAGES')],
              ),
            ]),
            li([
              a(
                href: '/',
                classes: 'admin-nav-link scramble-text magnetic',
                attributes: {'data-text': 'VIEW SITE', 'data-strength': '15'},
                [Component.text('VIEW SITE')],
              ),
            ]),
          ]),
        ]),
      ]),
      div(classes: 'admin-content', [child]),
    ]);
  }
}
