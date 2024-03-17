import 'dart:convert';

import 'package:AthletiX/model/profile.dart';

import 'message.dart';

List<Conversation> conversationListFromJson(String str) => List<Conversation>.from(json.decode(str).map((x) => Conversation.fromJson(x)));
Conversation conversationFromJson(String str) => Conversation.fromJson(json.decode(str));
String conversationToJson(Conversation data) => json.encode(data.toJson());

class Conversation {
  int id;
  List<Profile> profiles;
  List<Message> messages;

  Conversation({
    required this.id,
    required this.profiles,
    required this.messages,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
    id: json["id"],
    profiles: List<Profile>.from(json["profiles"].map((x) => Profile.fromJson(x))),
    messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profiles": List<dynamic>.from(profiles.map((x) => x.toJson())),
    "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
  };
}
