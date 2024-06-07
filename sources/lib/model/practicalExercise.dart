import 'dart:convert';
import 'package:AthletiX/model/exercise.dart';
import 'package:AthletiX/model/session.dart';

import 'category.dart';
import 'set.dart';

List<PracticalExercise> practicalexerciseListFromJson(String str) => List<PracticalExercise>.from(json.decode(str).map((x) => PracticalExercise.fromJson(x)));
PracticalExercise practicalexerciseFromJson(String str) => PracticalExercise.fromJson(json.decode(str));
String practicalexerciseToJson(PracticalExercise data) => json.encode(data.toJson());

class PracticalExercise {
  int id;
  Exercise exercise;
  Session session;
  List<Set> sets;

  PracticalExercise({
    required this.id,
    required this.exercise,
    required this.session,
    required this.sets,
  });

  factory PracticalExercise.fromJson(Map<String, dynamic> json) => PracticalExercise(
    id: json["id"],
    exercise: Exercise.fromJson(json["exercise"]),
    session: Session.fromJson(json["session"]),
    sets: List<Set>.from(json["sets"].map((x) => Set.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "exercise": exercise.toJson(),
    "session": session.toJson(),
    "sets": List<dynamic>.from(sets.map((x) => x.toJson())),
  };
}

