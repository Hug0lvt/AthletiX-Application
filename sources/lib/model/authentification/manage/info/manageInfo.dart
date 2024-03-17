import 'dart:convert';

String manageInfoToJson(ManageInfo data) => json.encode(data.toJson());

class ManageInfo {
  String newEmail;
  String newPassword;
  String oldPassword;

  ManageInfo({
    required this.newEmail,
    required this.newPassword,
    required this.oldPassword,
  });

  Map<String, dynamic> toJson() => {
    "newEmail": newEmail,
    "newPassword": newPassword,
    "oldPassword": oldPassword,
  };
}