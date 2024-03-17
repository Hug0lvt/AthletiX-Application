import 'dart:convert';

import 'exercise.dart';
import 'profile.dart';

List<Session> sessionListFromJson(String str) => List<Session>.from(json.decode(str).map((x) => Session.fromJson(x)));
Session sessionFromJson(String str) => Session.fromJson(json.decode(str));
String sessionToJson(Session data) => json.encode(data.toJson());

class Session {
  int id;
  Profile profile;
  String name;
  DateTime date;
  Duration duration;
  List<Exercise> exercises;

  Session({
    required this.id,
    required this.profile,
    required this.name,
    required this.date,
    required this.duration,
    required this.exercises,
  });

  factory Session.fromJson(Map<String, dynamic> json) => Session(
    id: json["id"],
    profile: Profile.fromJson(json["profile"]),
    name: json["name"],
    date: DateTime.parse(json["date"]),
    duration: Duration(milliseconds: json["duration"]),
    exercises: List<Exercise>.from(json["exercises"].map((x) => Exercise.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile": profile.toJson(),
    "name": name,
    "date": date.toIso8601String(),
    "duration": duration.inMilliseconds,
    "exercises": List<dynamic>.from(exercises.map((x) => x.toJson())),
  };
}