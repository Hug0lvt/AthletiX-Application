import 'dart:convert';

String refreshToJson(Refresh data) => json.encode(data.toJson());

class Refresh {
  String refreshToken;

  Refresh({
    required this.refreshToken,
  });

  Map<String, dynamic> toJson() => {
    "refreshToken": refreshToken,
  };
}