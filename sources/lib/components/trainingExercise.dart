import 'package:AthletiX/components/trainingSet.dart';
import 'package:flutter/cupertino.dart';
import 'package:AthletiX/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../model/exercise.dart';

class TrainingExercise extends StatefulWidget {
  final Exercise exercise;

  const TrainingExercise({Key? key, required this.exercise}) : super(key: key);

  @override
  _TrainingExerciseWidgetState createState() => _TrainingExerciseWidgetState();
}

class _TrainingExerciseWidgetState extends State<TrainingExercise> {
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
                  widget.exercise.name,
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
              return TrainingSet(set: set);
            }).toList(),
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