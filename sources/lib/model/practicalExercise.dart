import 'dart:convert';
import 'package:AthletiX/model/exercise.dart';

import 'category.dart';
import 'set.dart';

List<PracticalExercise> practicalexerciseListFromJson(String str) => List<PracticalExercise>.from(json.decode(str).map((x) => PracticalExercise.fromJson(x)));
PracticalExercise practicalexerciseFromJson(String str) => PracticalExercise.fromJson(json.decode(str));
String practicalexerciseToJson(PracticalExercise data) => json.encode(data.toJson());

class PracticalExercise {
  int id;
  String name;
  String description;
  String image;
  Category category;
  List<Set> sets;

  PracticalExercise({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.category,
    required this.sets,
  });

  factory PracticalExercise.fromJson(Map<String, dynamic> json) => PracticalExercise(
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

  // Function to convert from PracticalExercise to Exercise
  Exercise practicalExerciseToExercise() {
    return Exercise(
      id: this.id,
      name: this.name,
      description: this.description,
      image: this.image,
      category: this.category,
    );
  }
}

