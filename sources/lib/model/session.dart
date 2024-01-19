import 'profile.dart';
import 'exercise.dart';

class Session {
  int id;
  Profile profile;
  String name;
  DateTime date;
  Duration duration;
  List<Exercise> exercises;

  Session({
    required this.id,
    required this.profile,
    required this.name,
    required this.date,
    required this.duration,
    this.exercises = const [],
  });

  Session.partial({
    int? id,
    Profile? profile,
    String? name,
    DateTime? date,
    Duration? duration,
    List<Exercise>? exercises,
  })  : id = id ?? 0,
        profile = profile ?? Profile.partial(),
        name = name ?? '',
        date = date ?? DateTime.now(),
        duration = duration ?? Duration(),
        exercises = exercises ?? [];

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'] as int,
      profile: Profile.fromJson(json['profile'] as Map<String, dynamic>),
      name: json['name'] as String,
      date: DateTime.parse(json['date'] as String),
      duration: Duration(seconds: json['durationInSeconds'] as int),
      exercises: (json['exercises'] as List<dynamic>?)
          ?.map((exercise) => Exercise.fromJson(exercise as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profile': profile.toJson(),
      'name': name,
      'date': date.toIso8601String(),
      'durationInSeconds': duration.inSeconds,
      'exercises': exercises.map((exercise) => exercise.toJson()).toList(),
    };
  }
}
