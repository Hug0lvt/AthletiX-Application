import 'dart:convert';

import 'package:AthletiX/model/post.dart';
import 'package:AthletiX/model/profile.dart';

List<Comment> commentListFromJson(String str) => List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));
Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));
String commentToJson(Comment data) => json.encode(data.toJson());

class Comment {
  int id;
  int? parentCommentId;
  DateTime publishDate;
  Profile publisher;
  String content;
  List<Comment> answers = [];
  Post post;

  Comment({
    required this.id,
    required this.parentCommentId,
    required this.publishDate,
    required this.publisher,
    required this.content,
    required this.answers,
    required this.post,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
      parentCommentId: json["parentCommentId"],
    publishDate: DateTime.parse(json["publishDate"]),
    publisher: Profile.fromJson(json["publisher"]),
    content: json["content"],
    answers: List<Comment>.from(json["answers"].map((x) => x)),
    post: Post.fromJson(json["post"])
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parentCommentId": parentCommentId,
    "publishDate": publishDate.toIso8601String(),
    "publisher": publisher.toJson(),
    "content": content,
    "answers": List<dynamic>.from(answers.map((x) => x)),
    "post": post.toJson(),
  };
}
