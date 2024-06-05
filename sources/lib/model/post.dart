import 'dart:convert';

import 'comment.dart';
import 'profile.dart';
import 'category.dart';

List<Post> postListFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));
Post postFromJson(String str) => Post.fromJson(json.decode(str));
String postToJson(Post data) => json.encode(data.toJson());

class Post {
  int id;
  Profile publisher;
  Category category;
  String title;
  String description;
  int publicationType;
  String content;
  List<Comment> comments = [];

  Post({
    required this.id,
    required this.publisher,
    required this.category,
    required this.title,
    required this.description,
    required this.publicationType,
    required this.content,
    required this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    publisher: Profile.fromJson(json["publisher"]),
    category: Category.fromJson(json["category"]),
    title: json["title"],
    description: json["description"],
    publicationType: json["publicationType"],
    content: json["content"],
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "publisher": publisher.toJson(),
    "category": category.toJson(),
    "title": title,
    "description": description,
    "publicationType": publicationType,
    "content": content,
    "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
  };
}
