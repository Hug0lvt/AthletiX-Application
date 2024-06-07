import 'dart:convert';

import 'package:AthletiX/model/practicalExercise.dart';
import 'package:AthletiX/utils/utils.dart';
import 'profile.dart';

List<Session> sessionListFromJson(String str) => List<Session>.from(json.decode(str).map((x) => Session.fromJson(x)));
Session sessionFromJson(String str) => Session.fromJson(json.decode(str));
String sessionToJson(Session data) => json.encode(data.toJson());

class Session {
  int? id;
  Profile profile;
  String name;
  DateTime? date;
  Duration? duration;
  List<PracticalExercise> exercises;
  int status;

  Session({
    this.id,
    required this.profile,
    required this.name,
    this.date,
    this.duration,
    required this.exercises,
    required this.status
  });

  factory Session.fromJson(Map<String, dynamic> json) => Session(
    id: json["id"],
    profile: Profile.fromJson(json["profile"]),
    name: json["name"],
    date: DateTime.parse(json["date"]),
    duration: Utils.parseDuration(json["duration"]),
    exercises: List<PracticalExercise>.from(json["exercises"].map((x) => PracticalExercise.fromJson(x))),
    status: 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile": profile.toJson(),
    "name": name,
    "date": date?.toUtc().toIso8601String(),
    "duration": Utils.formatDuration(duration!),
    "practicalexercises": List<dynamic>.from(exercises.map((x) => x.toJson())),
    "status": status
  };

  /*Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "profile": profile.toJson(),
      "name": name,
      "practicalexercises": List<dynamic>.from(exercises.map((x) => x.toJson())),
    };
    if (id != null) {
      data["id"] = id;
    }
    if (date != null) {
      data["date"] = date?.toUtc().toIso8601String();
    }
    if (duration != null) {
      data["duration"] = duration?.inMilliseconds;
    }
    return data;
  }
*/
}