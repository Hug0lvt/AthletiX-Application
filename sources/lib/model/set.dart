import 'enums/setMode.dart';

class Set {
  int id;
  int reps;
  List<double> weight;
  Duration rest;
  SetMode mode;

  Set({
    required this.id,
    required this.reps,
    this.weight = const [],
    required this.rest,
    required this.mode,
  });

  Set.partial({
    int? id,
    int? reps,
    List<double>? weight,
    Duration? rest,
    SetMode? mode,
  })  : id = id ?? 0,
        reps = reps ?? 0,
        weight = weight ?? [],
        rest = rest ?? Duration(),
        mode = mode ?? SetMode.normal;

  factory Set.fromJson(Map<String, dynamic> json) {
    return Set(
      id: json['id'] as int,
      reps: json['reps'] as int,
      weight: (json['weight'] as List<dynamic>?)
          ?.map((w) => (w as num).toDouble())
          .toList() ??
          [],
      rest: Duration(seconds: json['restInSeconds'] as int),
      mode: SetMode.values.firstWhere((e) => e.toString() == 'SetMode.' + json['mode']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reps': reps,
      'weight': weight,
      'restInSeconds': rest.inSeconds,
      'mode': mode.toString().split('.')[1],
    };
  }
}
