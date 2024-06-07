import 'package:AthletiX/components/trainingSet.dart';
import 'package:flutter/cupertino.dart';
import 'package:AthletiX/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../main.dart';
import '../model/exercise.dart';
import '../model/practicalExercise.dart';
import '../model/set.dart';
import '../providers/api/utils/practicalexerciseClientApi.dart';
import '../providers/api/utils/setClientApi.dart';

class TrainingExercise extends StatefulWidget {
  late PracticalExercise exercise;
  late int status;

  TrainingExercise({Key? key, required this.exercise, required this.status}) : super(key: key);

  @override
  _TrainingExerciseWidgetState createState() => _TrainingExerciseWidgetState();
}

class _TrainingExerciseWidgetState extends State<TrainingExercise> {

  final practicalExerciseClientApi = getIt<PracticalExerciseClientApi>();
  final setClientApi = getIt<SetClientApi>();

  void _addSet() async {
    Set setToAdd = Set(
        id: 0,
        reps: 0,
        weight: [],
        rest: Duration(minutes: 0, seconds: 0),
        mode: 0,
        exercise: widget.exercise,
        isDone: false
    );

    await setClientApi.createSet(setToAdd, widget.exercise.id);

    PracticalExercise newPracticalExercise = await practicalExerciseClientApi.getPracticalExerciseById(widget.exercise.id);

    widget.exercise = newPracticalExercise;

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Row(
              children: [
                Text(
                  widget.exercise.exercise.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 3.0,
                    indent: 16.0,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: widget.exercise.sets.map((set) {
              return TrainingSet(set: set, status: widget.exercise.session!.status);
            }).toList(),
          ),
          Align(
            alignment: Alignment.center,
            child: widget.status == 0 || widget.status == 1
                ? TextButton(
              onPressed: () {
                _addSet();
              },
              child: const Text(
                'Add set',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ) : Container(),
          ),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(
                color: Colors.grey,
                thickness: 3,
              ),
          ),
        ],
      ),
    );
  }
}