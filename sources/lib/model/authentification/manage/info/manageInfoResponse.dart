import 'dart:convert';

ManageInfoResponse manageInfoResponseFromJson(String str) => ManageInfoResponse.fromJson(json.decode(str));

class ManageInfoResponse {
  String email;
  bool isEmailConfirmed;

  ManageInfoResponse({
    required this.email,
    required this.isEmailConfirmed,
  });

  factory ManageInfoResponse.fromJson(Map<String, dynamic> json) => ManageInfoResponse(
    email: json["email"],
    isEmailConfirmed: json["isEmailConfirmed"],
  );

}