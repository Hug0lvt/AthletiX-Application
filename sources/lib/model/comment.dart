import 'profile.dart';

class Comment {
  int id;
  DateTime publishDate;
  Profile publisher;
  String content;
  List<Comment> answers;

  Comment({
    required this.id,
    required this.publishDate,
    required this.publisher,
    required this.content,
    this.answers = const [],
  });

  Comment.partial({
    this.id = 0,
    DateTime? publishDate,
    Profile? publisher,
    this.content = '',
    this.answers = const [],
  })  : publishDate = publishDate ?? DateTime.now(),
        publisher = publisher ?? Profile.partial();

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as int,
      publishDate: DateTime.parse(json['publishDate'] as String),
      publisher: Profile.fromJson(json['publisher'] as Map<String, dynamic>),
      content: json['content'] as String,
      answers: (json['answers'] as List<dynamic>?)
          ?.map((answer) => Comment.fromJson(answer as Map<String, dynamic>))
          .toList() ?? []
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'publishDate': publishDate.toIso8601String(),
      'publisher': publisher.toJson(),
      'content': content,
      'answers': answers.map((answer) => answer.toJson()).toList(),
    };
  }
}
