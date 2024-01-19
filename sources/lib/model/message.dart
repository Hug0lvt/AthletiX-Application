import 'profile.dart';

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

  Message.partial({
    int? id,
    String? content,
    DateTime? dateSent,
    Profile? sender,
  })  : id = id ?? 0,
        content = content ?? '',
        dateSent = dateSent ?? DateTime.now(),
        sender = sender ?? Profile.partial();

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as int,
      content: json['content'] as String,
      dateSent: DateTime.parse(json['dateSent'] as String),
      sender: Profile.fromJson(json['sender'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'dateSent': dateSent.toIso8601String(),
      'sender': sender.toJson(),
    };
  }
}
