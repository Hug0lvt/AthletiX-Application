import 'dart:convert';

import 'package:AthletiX/model/profile.dart';

List<Comment> commentListFromJson(String str) => List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));
Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));
String commentToJson(Comment data) => json.encode(data.toJson());

class Comment {
  int id;
  DateTime publishDate;
  Profile publisher;
  String content;
  List<String> answers;

  Comment({
    required this.id,
    required this.publishDate,
    required this.publisher,
    required this.content,
    required this.answers,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    publishDate: DateTime.parse(json["publishDate"]),
    publisher: Profile.fromJson(json["publisher"]),
    content: json["content"],
    answers: List<String>.from(json["answers"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "publishDate": publishDate.toIso8601String(),
    "publisher": publisher.toJson(),
    "content": content,
    "answers": List<dynamic>.from(answers.map((x) => x)),
  };
}
