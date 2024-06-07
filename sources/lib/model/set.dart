import 'dart:convert';

import 'package:AthletiX/model/practicalExercise.dart';
import 'package:AthletiX/utils/utils.dart';

List<Set> setListFromJson(String str) => List<Set>.from(json.decode(str).map((x) => Set.fromJson(x)));
Set setFromJson(String str) => Set.fromJson(json.decode(str));
String setToJson(Set data) => json.encode(data.toJson());

class Set {
  int id;
  int reps;
  List<int> weight;
  Duration rest;
  int mode;
  PracticalExercise? exercise;
  bool isDone;

  Set({
    required this.id,
    required this.reps,
    required this.weight,
    required this.rest,
    required this.mode,
    this.exercise,
    required this.isDone
  });

  factory Set.fromJson(Map<String, dynamic> json) => Set(
    id: json["id"],
    reps: json["reps"],
    weight: List<int>.from(json["weight"].map((x) => x)),
    rest: Utils.parseDuration(json["rest"]),
    mode: json["mode"],
    exercise: json["exercise"].toString().isEmpty ? PracticalExercise.fromJson(json["exercise"]) : null,
    isDone: json["isDone"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reps": reps,
    "weight": List<dynamic>.from(weight.map((x) => x)),
    "rest": Utils.formatDuration(rest),
    "mode": mode,
    "exercise" : exercise?.toJson(),
    "isDone" : isDone
  };

  Map<String, dynamic> toJsonWithId(int exerciceId) => {
    "id": id,
    "reps": reps,
    "weight": List<dynamic>.from(weight.map((x) => x)),
    "rest": Utils.formatDuration(rest),
    "mode": mode,
    "practicalExerciseId" : exerciceId,
    "isDone" : isDone
  };
}