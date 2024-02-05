import 'enums/role.dart';

class Profile {
  int id;
  String username;
  String mail;
  String uniqueNotificationToken;
  Role role;
  int age;
  String email;
  double weight;
  double height;

  Profile({
    required this.id,
    required this.username,
    required this.mail,
    required this.uniqueNotificationToken,
    required this.role,
    required this.age,
    required this.email,
    required this.weight,
    required this.height,
  });

  Profile.partial({
    this.id = 0,
    this.username = '',
    this.mail = '',
    this.uniqueNotificationToken = '',
    this.role = Role.user,
    this.age = 0,
    this.email = '',
    this.weight = 0.0,
    this.height = 0.0,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] as int,
      username: json['username'] as String,
      mail: json['mail'] as String,
      uniqueNotificationToken: json['uniqueNotificationToken'] as String,
      //role: Role.values.firstWhere((e) => e.toString() == 'Role.' + json['role'].toString()),
      role: Role.user,
      age: json['age'] as int,
      email: json['email'] as String,
      weight: json['weight'] as double,
      height: json['height'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'mail': mail,
      'uniqueNotificationToken': uniqueNotificationToken,
      'role': role.toString().split('.')[1],
      'age': age,
      'email': email,
      'weight': weight,
      'height': height,
    };
  }
}
