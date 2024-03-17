import 'dart:convert';

Error errorFromJson(String str) => Error.fromJson(json.decode(str));

class Error {
  String type;
  String title;
  int status;
  Map<String, String> errors;

  Error({
    required this.type,
    required this.title,
    required this.status,
    required this.errors,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    type: json["type"],
    title: json["title"],
    status: json["status"],
    errors: Map<String, String>.from(json["errors"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "title": title,
    "status": status,
    "errors": errors,
  };
}
