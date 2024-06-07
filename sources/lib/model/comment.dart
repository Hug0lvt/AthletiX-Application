import 'dart:convert';

import 'package:AthletiX/model/post.dart';
import 'package:AthletiX/model/profile.dart';

import 'exercise.dart';

List<Comment> commentListFromJson(String str) => List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));
Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));
String commentToJson(Comment data) => json.encode(data.toJson());

class Comment {
  int? id;
  int? parentCommentId;
  DateTime? publishDate;
  Profile? publisher;
  String? content;
  List<Comment>? answers;
  int? postId;

  Comment({
    this.id,
    this.parentCommentId,
    this.publishDate,
    this.publisher,
    this.content,
    this.answers,
    this.postId,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    parentCommentId: json["parentCommentId"],
    publishDate: json["publishDate"] != null ? DateTime.parse(json["publishDate"]) : null,
    publisher: json["publisher"] != null ? Profile.fromJson(json["publisher"]) : null,
    content: json["content"],
    answers: json["answers"] != null ? List<Comment>.from(json["answers"].map((x) => Comment.fromJson(x))) : [],
    postId: json["postId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parentCommentId": parentCommentId,
    "publishDate": publishDate?.toUtc().toIso8601String(),
    "publisher": publisher?.toJson(),
    "content": content,
    "answers": answers != null ? List<dynamic>.from(answers!.map((x) => x.toJson())) : [],
    "postId": postId,
  };
}
