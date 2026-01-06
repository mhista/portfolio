import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'admin_layout.dart';

@client
class AdminDashboard extends StatefulComponent {
  @override
  State createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final stats = {
    'projects': 12,
    'blogPosts': 24,
    'messages': 8,
    'views': 1247,
  };

  @override
  Component build(BuildContext context)  {
    return AdminLayout(
      child: div(classes: 'admin-page fade-in', [
        h1(
          classes: 'admin-title scramble-text gradient-text',
          attributes: {'data-text': 'DASHBOARD'},
          [Component.text('DASHBOARD')],
        ),
        
        div(classes: 'dashboard-stats', [
          div(classes: 'stat-card hover-lift', [
            div(classes: 'stat-icon', [Component.text('📁')]),
            div(classes: 'stat-content', [
              h3(
                classes: 'stat-value scramble-text',
                attributes: {'data-text': stats['projects'].toString()},
                [Component.text(stats['projects'].toString())],
              ),
              p(classes: 'stat-label', [Component.text('PROJECTS')]),
            ]),
          ]),
          
          div(classes: 'stat-card hover-lift', [
            div(classes: 'stat-icon', [Component.text('📝')]),
            div(classes: 'stat-content', [
              h3(
                classes: 'stat-value scramble-text',
                attributes: {'data-text': stats['blogPosts'].toString()},
                [Component.text(stats['blogPosts'].toString())],
              ),
              p(classes: 'stat-label', [Component.text('BLOG POSTS')]),
            ]),
          ]),
          
          div(classes: 'stat-card hover-lift', [
            div(classes: 'stat-icon', [Component.text('💌')]),
            div(classes: 'stat-content', [
              h3(
                classes: 'stat-value scramble-text',
                attributes: {'data-text': stats['messages'].toString()},
                [Component.text(stats['messages'].toString())],
              ),
              p(classes: 'stat-label', [Component.text('NEW MESSAGES')]),
            ]),
          ]),
          
          div(classes: 'stat-card hover-lift', [
            div(classes: 'stat-icon', [Component.text('👁️')]),
            div(classes: 'stat-content', [
              h3(
                classes: 'stat-value scramble-text',
                attributes: {'data-text': stats['views'].toString()},
                [Component.text(stats['views'].toString())],
              ),
              p(classes: 'stat-label', [Component.text('TOTAL VIEWS')]),
            ]),
          ]),
        ]),

        h2(
          classes: 'section-subtitle scramble-text',
          attributes: {'data-text': 'QUICK ACTIONS'},
          [Component.text('QUICK ACTIONS')],
        ),
        
        div(classes: 'quick-actions blur-siblings-container', [
          a(
            href: '/admin/projects',
            classes: 'action-card blur-siblings hover-lift magnetic',
            attributes: {'data-strength': '20'},
            [
              span(classes: 'action-icon', [Component.text('📁')]),
              h3([Component.text('MANAGE PROJECTS')]),
              p([Component.text('Add, edit, or delete projects')]),
            ],
          ),
          
          a(
            href: '/admin/blog',
            classes: 'action-card blur-siblings hover-lift magnetic',
            attributes: {'data-strength': '20'},
            [
              span(classes: 'action-icon', [Component.text('📝')]),
              h3([Component.text('MANAGE BLOG')]),
              p([Component.text('Create and publish blog posts')]),
            ],
          ),
          
          a(
            href: '/admin/messages',
            classes: 'action-card blur-siblings hover-lift magnetic',
            attributes: {'data-strength': '20'},
            [
              span(classes: 'action-icon', [Component.text('💌')]),
              h3([Component.text('VIEW MESSAGES')]),
              p([Component.text('Read contact form submissions')]),
            ],
          ),
        ]),
      ]),
    );
  }
}