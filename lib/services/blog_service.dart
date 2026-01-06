import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/blog_post.dart';

class BlogService {
  static const String baseUrl = 'http://localhost:8080';

  static Future<List<BlogPost>> getAllPosts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/blog/posts'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => BlogPost.fromJson(json)).toList();
      }
      throw Exception('Failed to load posts');
    } catch (e) {
      return _getMockPosts();
    }
  }

  static Future<List<BlogPost>> getPublishedPosts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/blog/posts/published'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => BlogPost.fromJson(json)).toList();
      }
      throw Exception('Failed to load posts');
    } catch (e) {
      return _getMockPosts().where((p) => p.published).toList();
    }
  }

  static Future<BlogPost?> getPostBySlug(String slug) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/blog/posts/$slug'));
      if (response.statusCode == 200) {
        return BlogPost.fromJson(jsonDecode(response.body));
      }
      return null;
    } catch (e) {
      return _getMockPosts().firstWhere((p) => p.slug == slug);
    }
  }

  static List<BlogPost> _getMockPosts() {
    return [
      BlogPost(
        id: '1',
        title: 'Building Modern Web Apps with Jaspr',
        content: 'Full content here...',
        excerpt: 'Learn how to build fast, modern web applications using Jaspr framework.',
        coverImage: 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=1200',
        slug: 'building-modern-web-apps-jaspr',
        tags: ['Jaspr', 'Dart', 'Web Development'],
        publishedAt: DateTime.now().subtract(Duration(days: 5)),
        published: true,
        readTime: 8,
      ),
    ];
  }
}