import 'dart:convert';

import 'package:AthletiX/model/profile.dart';

List<Message> messageListFromJson(String str) => List<Message>.from(json.decode(str).map((x) => Message.fromJson(x)));
Message messageFromJson(String str) => Message.fromJson(json.decode(str));
String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  int id;
  String content;
  DateTime dateSent;
  Profile sender;

  Message({
    required this.id,
    required this.content,
    required this.dateSent,
    required this.sender,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    content: json["content"],
    dateSent: DateTime.parse(json["dateSent"]),
    sender: Profile.fromJson(json["sender"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "dateSent": dateSent.toIso8601String(),
    "sender": sender.toJson(),
  };
}
