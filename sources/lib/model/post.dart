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
  Profile publisher;
  Category category;
  String title;
  String description;
  int publicationType;
  String content;
  List<Comment> comments = [];
  // Stub exo en attendant l'api
  List<Exercise> exercises = [
    Exercise(
    id: 1,
    name: 'Push-up',
    description: 'A basic upper body exercise that targets the chest, shoulders, and triceps.',
    image: 'https://via.placeholder.com/150?text=Push-up',
    category: Category(id: 1, title: 'Haut du Corps'),
    ),
    Exercise(
    id: 2,
    name: 'Squat',
    description: 'A fundamental lower body exercise that targets the quadriceps, hamstrings, and glutes.',
    image: 'https://via.placeholder.com/150?text=Squat',
    category: Category(id: 2, title: 'Bas du Corps'),
    ),
    Exercise(
    id: 3,
    name: 'Plank',
    description: 'A core exercise that helps build strength and stability in the abdominal muscles and lower back.',
    image: 'https://via.placeholder.com/150?text=Plank',
    category: Category(id: 3, title: 'Abdos'),
    ),
    Exercise(
    id: 4,
    name: 'Bicep Curl',
    description: 'An isolation exercise that targets the biceps muscles.',
    image: 'https://via.placeholder.com/150?text=Bicep+Curl',
    category: Category(id: 1, title: 'Haut du Corps'),
    ),
    Exercise(
    id: 5,
    name: 'Lunge',
    description: 'A lower body exercise that targets the quadriceps, hamstrings, and glutes.',
    image: 'https://via.placeholder.com/150?text=Lunge',
    category: Category(id: 2, title: 'Bas du Corps'),
    ),
    Exercise(
    id: 6,
    name: 'Bench Press',
    description: 'A chest exercise that targets the pectoral muscles, shoulders, and triceps.',
    image: 'https://via.placeholder.com/150?text=Bench+Press',
    category: Category(id: 4, title: 'Pecs'),
    ),
    Exercise(
    id: 7,
    name: 'Leg Press',
    description: 'A lower body exercise that primarily targets the quadriceps, hamstrings, and glutes.',
    image: 'https://via.placeholder.com/150?text=Leg+Press',
    category: Category(id: 5, title: 'Legs'),
    ),
  ];

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

