import 'dart:convert';

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  String email;
  String password;
  String? twoFactorCode = "";
  String? twoFactorRecoveryCode = "";

  Login({
    required this.email,
    required this.password,
    this.twoFactorCode,
    this.twoFactorRecoveryCode,
  });

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "twoFactorCode": twoFactorCode,
    "twoFactorRecoveryCode": twoFactorRecoveryCode,
  };
}
