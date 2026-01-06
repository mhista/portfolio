class Project {
  final String id;
  final String title;
  final String description;
  final String category;
  final String imageUrl;
  final String year;
  final int order;
  final bool featured;
  final List<String> technologies;
  final String? projectUrl;
  final String? githubUrl;
  final List<String>? images;
  final List<String>? results;
  final bool isMobile;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.year,
    required this.order,
    this.featured = false,
    this.technologies = const [],
    this.projectUrl,
    this.githubUrl,
    this.images,
    this.results,
    this.isMobile = false,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String,
      year: json['year'] as String,
      order: json['order'] as int,
      featured: json['featured'] as bool? ?? false,
      technologies: (json['technologies'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      projectUrl: json['projectUrl'] as String?,
      githubUrl: json['githubUrl'] as String?,
      images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      results: (json['results'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      isMobile: json['isMobile'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'imageUrl': imageUrl,
      'year': year,
      'order': order,
      'featured': featured,
      'technologies': technologies,
      'projectUrl': projectUrl,
      'githubUrl': githubUrl,
      'images': images,
      'results': results,
      'isMobile': isMobile,
    };
  }
}