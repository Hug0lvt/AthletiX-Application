import 'dart:convert';

List<Profile> profileListFromJson(String str) => List<Profile>.from(json.decode(str).map((x) => Profile.fromJson(x)));
Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));
String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  int? id;
  String? username;
  String? uniqueNotificationToken;
  int? role;
  int? age;
  String? email;
  int? weight;
  int? height;

  Profile({
    this.id,
    this.username,
    this.uniqueNotificationToken,
    this.role,
    this.age,
    this.email,
    this.weight,
    this.height,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    username: json["username"],
    uniqueNotificationToken: json["uniqueNotificationToken"],
    role: json["role"],
    age: json["age"],
    email: json["email"],
    weight: json["weight"],
    height: json["height"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "uniqueNotificationToken": uniqueNotificationToken,
    "role": role,
    "age": age,
    "email": email,
    "weight": weight,
    "height": height,
  };
}
