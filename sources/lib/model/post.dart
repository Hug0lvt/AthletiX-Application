import 'enums/publication_type.dart';
import 'profile.dart';
import 'category.dart';
import 'comment.dart';

class Post {
  int id;
  Profile publisher;
  Category category;
  String title;
  String description;
  PublicationType publicationType;
  String content;
  List<Comment> comments;

  Post({
    required this.id,
    required this.publisher,
    required this.category,
    required this.title,
    required this.description,
    required this.publicationType,
    required this.content,
    this.comments = const [],
  });

  Post.partial({
    int? id,
    Profile? publisher,
    Category? category,
    String? title,
    String? description,
    PublicationType? publicationType,
    String? content,
    List<Comment>? comments,
  })  : id = id ?? 0,
        publisher = publisher ?? Profile.partial(),
        category = category ?? Category.partial(),
        title = title ?? '',
        description = description ?? '',
        publicationType = publicationType ?? PublicationType.image,
        content = content ?? '',
        comments = comments ?? [];

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      publisher: Profile.fromJson(json['publisher'] as Map<String, dynamic>),
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      title: json['title'] as String,
      description: json['description'] as String,
      publicationType: PublicationType.values.firstWhere((e) => e.toString() == 'PublicationType.' + json['publicationType']),
      content: json['content'] as String,
      comments: (json['comments'] as List<dynamic>?)
          ?.map((comment) => Comment.fromJson(comment as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'publisher': publisher.toJson(),
      'category': category.toJson(),
      'title': title,
      'description': description,
      'publicationType': publicationType.toString().split('.')[1],
      'content': content,
      'comments': comments.map((comment) => comment.toJson()).toList(),
    };
  }
}
