import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import '../../models/blog_post.dart';
import '../../services/blog_service.dart';
import 'admin_layout.dart';

@client
class BlogAdmin extends StatefulComponent {
  @override
  State createState() => _BlogAdminState();
}

class _BlogAdminState extends State<BlogAdmin> {
  List<BlogPost> posts = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    final data = await BlogService.getAllPosts();
    setState(() {
      posts = data;
      loading = false;
    });
  }

  @override
  Component build(BuildContext context) {
    return AdminLayout(
      child: div(classes: 'admin-page fade-in', [
        div(classes: 'admin-header', [
          h1(classes: 'admin-title scramble-text gradient-text',
             attributes: {'data-text': 'BLOG POSTS'},
             [Component.text('BLOG POSTS')]),
          button(
            classes: 'admin-btn admin-btn-primary magnetic pulse',
            attributes: {'data-strength': '15'},
            [Component.text('+ NEW POST')],
          ),
        ]),

        if (loading)
          div(classes: 'admin-loading', [
            span(classes: 'scramble-text', [Component.text('LOADING...')]),
          ])
        else
          div(classes: 'admin-table-container', [
            table(classes: 'admin-table', [
              thead([
                tr([
                  th([Component.text('TITLE')]),
                  th([Component.text('STATUS')]),
                  th([Component.text('PUBLISHED')]),
                  th([Component.text('ACTIONS')]),
                ]),
              ]),
              tbody([
                for (var post in posts)
                  tr(classes: 'fade-in', [
                    td([
                      span(classes: 'scramble-text',
                           attributes: {'data-text': post.title},
                           [Component.text(post.title)]),
                    ]),
                    td([
                      span(
                        classes: 'status-badge ${post.published ? 'status-published' : 'status-draft'}',
                        [Component.text(post.published ? 'PUBLISHED' : 'DRAFT')],
                      ),
                    ]),
                    td([Component.text(post.publishedAt.toString().substring(0, 10))]),
                    td(classes: 'table-actions', [
                      button(classes: 'admin-btn admin-btn-sm magnetic',
                             attributes: {'data-strength': '10'},
                             [Component.text('EDIT')]),
                      button(classes: 'admin-btn admin-btn-sm admin-btn-danger magnetic',
                             attributes: {'data-strength': '10'},
                             [Component.text('DELETE')]),
                    ]),
                  ]),
              ]),
            ]),
          ]),
      ]),
    );
  }
}