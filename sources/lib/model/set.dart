import 'dart:convert';

List<Set> setListFromJson(String str) => List<Set>.from(json.decode(str).map((x) => Set.fromJson(x)));
Set setFromJson(String str) => Set.fromJson(json.decode(str));
String setToJson(Set data) => json.encode(data.toJson());

class Set {
  int id;
  int reps;
  List<int> weight;
  Duration rest;
  int mode;

  Set({
    required this.id,
    required this.reps,
    required this.weight,
    required this.rest,
    required this.mode,
  });

  factory Set.fromJson(Map<String, dynamic> json) => Set(
    id: json["id"],
    reps: json["reps"],
    weight: List<int>.from(json["weight"].map((x) => x)),
    rest: Duration(milliseconds: json["rest"]),
    mode: json["mode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reps": reps,
    "weight": List<dynamic>.from(weight.map((x) => x)),
    "rest": rest.inMilliseconds,
    "mode": mode,
  };
}