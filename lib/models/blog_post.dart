// ============================================
// FILE: lib/models/blog_post.dart
// ============================================
class BlogPost {
  final String id;
  final String title;
  final String content;
  final String excerpt;
  final String coverImage;
  final String slug;
  final List<String> tags;
  final DateTime publishedAt;
  final bool published;
  final int readTime;

  BlogPost({
    required this.id,
    required this.title,
    required this.content,
    required this.excerpt,
    required this.coverImage,
    required this.slug,
    required this.tags,
    required this.publishedAt,
    required this.published,
    required this.readTime,
  });

  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      excerpt: json['excerpt'] as String,
      coverImage: json['coverImage'] as String,
      slug: json['slug'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      publishedAt: DateTime.parse(json['publishedAt'] as String),
      published: json['published'] as bool,
      readTime: json['readTime'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'excerpt': excerpt,
      'coverImage': coverImage,
      'slug': slug,
      'tags': tags,
      'publishedAt': publishedAt.toIso8601String(),
      'published': published,
      'readTime': readTime,
    };
  }
}
