import 'dart:convert';

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  String email;
  String password;

  Register({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}
