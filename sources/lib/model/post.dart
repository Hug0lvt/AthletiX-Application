import 'dart:convert';

import 'comment.dart';
import 'exercise.dart';
import 'profile.dart';
import 'category.dart';

List<Post> postListFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));
Post postFromJson(String str) => Post.fromJson(json.decode(str));
String postToJson(Post data) => json.encode(data.toJson());

class Post {
  int id;
  Profile? publisher;
  Category? category;
  String? title;
  String? description;
  int? publicationType;
  String? content;
  String? thumbnail;
  List<Comment>? comments;
  List<Exercise>? exercises;

  Post({
    required this.id,
    this.publisher,
    this.category,
    this.title,
    this.description,
    this.publicationType,
    this.content,
    this.thumbnail,
    this.comments,
    this.exercises,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    publisher: json["publisher"] != null ? Profile.fromJson(json["publisher"]) : null,
    category: json["category"] != null ? Category.fromJson(json["category"]) : null,
    title: json["title"],
    description: json["description"],
    publicationType: json["publicationType"],
    content: json["content"],
    thumbnail: json["thumbnail"],
    comments: json["comments"] != null ? List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))) : [],
    exercises: json["exercises"]!= null ? List<Exercise>.from(json["exercises"].map((x) => Exercise.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "publisher": publisher?.toJson(),
    "category": category?.toJson(),
    "title": title,
    "description": description,
    "publicationType": publicationType,
    "content": content,
    "thumbnail": thumbnail,
    "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
    "exercises": exercises != null ? List<dynamic>.from(exercises!.map((x) => x.toJson())) : [],
  };
}
