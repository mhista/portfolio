import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import '../models/blog_post.dart';
import '../services/blog_service.dart';
import '../components/footer.dart';

@client
class BlogPage extends StatefulComponent {
  @override
  State createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  List<BlogPost> posts = [];
  bool loading = true;
  String selectedTag = 'ALL';

  final List<String> tags = ['ALL', 'DESIGN', 'DEVELOPMENT', 'UI/UX', 'SYSTEMS'];

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    final data = await BlogService.getPublishedPosts();
    setState(() {
      posts = data;
      loading = false;
    });
  }

  List<BlogPost> get filteredPosts {
    if (selectedTag == 'ALL') return posts;
    return posts.where((pp) => pp.tags.contains(selectedTag)).toList();
  }

  @override
  Component build(BuildContext context)  {
    return section(classes: 'blog-page', [
      div(classes: 'blog-hero', [
        h1(
          classes: 'blog-title scramble-text gradient-text',
          attributes: {'data-text': 'BLOG'},
          [Component.text('BLOG')],
        ),
        p(classes: 'blog-subtitle fade-in', [
          Component.text('Thoughts on design, development, and everything in between.'),
        ]),
      ]),

      div(classes: 'blog-filters fade-in', [
        for (var tag in tags)
          button(
            classes: 'blog-filter-btn magnetic ${selectedTag == tag ? 'active' : ''}',
            attributes: {'data-strength': '15'},
            onClick: () => setState(() => selectedTag = tag),
            [
              span(
                classes: 'scramble-text',
                attributes: {'data-text': tag},
                [Component.text(tag)],
              ),
            ],
          ),
      ]),

      if (loading)
        div(classes: 'blog-loading', [
          span(classes: 'scramble-text', [Component.text('LOADING POSTS...')]),
        ])
      else
        div(classes: 'blog-grid blur-siblings-container', [
          for (var post in filteredPosts)
            a(
              href: '/blog/${post.slug}',
              classes: 'blog-card blur-siblings hover-lift rotate-hover',
              [
                img(classes: 'blog-card-image', src: post.coverImage, alt: post.title),
                div(classes: 'blog-card-content', [
                  div(classes: 'blog-card-meta', [
                    span(classes: 'blog-date', [
                      Component.text(post.publishedAt.toString().substring(0, 10)),
                    ]),
                    span(classes: 'blog-read-time', [Component.text('${post.readTime} min read')]),
                  ]),
                  h3(
                    classes: 'blog-card-title scramble-text',
                    attributes: {'data-text': post.title},
                    [Component.text(post.title)],
                  ),
                  p(classes: 'blog-card-excerpt', [Component.text(post.excerpt)]),
                  div(classes: 'blog-card-tags', [
                    for (var tag in post.tags.take(2))
                      span(classes: 'blog-tag', [Component.text(tag)]),
                  ]),
                ]),
              ],
            ),
        ]),
        Footer()
    ]);

  }
}