import 'dart:convert';
import 'category.dart';
import 'set.dart';

List<Exercise> exerciseListFromJson(String str) => List<Exercise>.from(json.decode(str).map((x) => Exercise.fromJson(x)));
Exercise exerciseFromJson(String str) => Exercise.fromJson(json.decode(str));
String exerciseToJson(Exercise data) => json.encode(data.toJson());

class Exercise {
  int id;
  String name;
  String description;
  String image;
  Category category;
  List<Set> sets;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.category,
    required this.sets,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    category: Category.fromJson(json["category"]),
    sets: List<Set>.from(json["sets"].map((x) => Set.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
    "category": category.toJson(),
    "sets": List<dynamic>.from(sets.map((x) => x.toJson())),
  };
}
