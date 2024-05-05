import 'dart:convert';

String resetPasswordToJson(ResetPassword data) => json.encode(data.toJson());

class ResetPassword {
  String email;
  String resetCode;
  String newPassword;

  ResetPassword({
    required this.email,
    required this.resetCode,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => {
    "email": email,
    "resetCode": resetCode,
    "newPassword": newPassword,
  };
}
