import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import '../models/blog_post.dart';
import '../services/blog_service.dart';
import '../components/footer.dart';

@client
class BlogPostPage extends StatefulComponent {
  final String slug;

  const BlogPostPage({required this.slug});

  @override
  State createState() => _BlogPostPageState();
}

class _BlogPostPageState extends State<BlogPostPage> {
  BlogPost? post;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadPost();
  }

  Future<void> _loadPost() async {
    final data = await BlogService.getPostBySlug(component.slug);
    setState(() {
      post = data;
      loading = false;
    });
  }

  @override
  Component build(BuildContext context)  {
    if (loading) {
      return div(classes: 'blog-post-loading', [
        span(classes: 'scramble-text', [Component.text('LOADING POST...')]),
      ]);
    }

    if (post == null) {
      return div(classes: 'blog-post-error', [
        h1([Component.text('POST NOT FOUND')]),
      ]);
    }

    return article(classes: 'blog-post', [
      header(classes: 'blog-post-header', [
        div(classes: 'blog-post-meta fade-in', [
          span(classes: 'blog-post-date', [
            Component.text(post!.publishedAt.toString().substring(0, 10)),
          ]),
          span(classes: 'blog-post-read-time', [Component.text('${post!.readTime} min read')]),
        ]),
        h1(
          classes: 'blog-post-title scramble-text gradient-text slide-in-left',
          attributes: {'data-text': post!.title},
          [Component.text(post!.title)],
        ),
        div(classes: 'blog-post-tags fade-in', [
          for (var tag in post!.tags)
            span(
              classes: 'blog-post-tag magnetic',
              attributes: {'data-strength': '10'},
              [Component.text(tag)],
            ),
        ]),
        img(
          classes: 'blog-post-cover hover-lift',
          src: post!.coverImage,
          alt: post!.title,
        ),
      ]),

      div(classes: 'blog-post-content fade-in', [
        p([Component.text(post!.content)]),
        // Add more content sections here
      ]),
       Footer()
    ]);

    
  }
}