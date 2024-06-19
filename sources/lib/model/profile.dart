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
  bool? gender;
  String? picture;

  Profile({
    this.id,
    this.username,
    this.uniqueNotificationToken,
    this.role,
    this.age,
    this.email,
    this.weight,
    this.height,
    this.gender,
    this.picture,
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
    gender: json["gender"],
    picture: json["picture"],
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
    "gender": gender,
    "picture": picture,
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Profile &&
        other.id == id &&
        other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode;
}
