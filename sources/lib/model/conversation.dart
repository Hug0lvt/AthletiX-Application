import 'profile.dart';
import 'message.dart';

class Conversation {
  int id;
  List<Profile> profiles;
  List<Message> messages;

  Conversation({
    required this.id,
    this.profiles = const [],
    this.messages = const [],
  });

  Conversation.partial({
    this.id = 0,
    this.profiles = const [],
    this.messages = const [],
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'] as int,
      profiles: (json['profiles'] as List<dynamic>?)
          ?.map((profile) => Profile.fromJson(profile as Map<String, dynamic>))
          .toList() ??
          [],
      messages: (json['messages'] as List<dynamic>?)
          ?.map((message) => Message.fromJson(message as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profiles': profiles.map((profile) => profile.toJson()).toList(),
      'messages': messages.map((message) => message.toJson()).toList(),
    };
  }
}
