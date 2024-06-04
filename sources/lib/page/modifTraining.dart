import 'package:AthletiX/components/trainingExercise.dart';
import 'package:AthletiX/model/exercise.dart';
import 'package:AthletiX/model/session.dart';
import 'package:AthletiX/page/trainingTabs/ExercicesTab.dart';
import 'package:AthletiX/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../model/category.dart';
import '../model/set.dart';
import '../model/profile.dart';
import '../providers/localstorage/secure/authKeys.dart';
import '../providers/localstorage/secure/authManager.dart';

class ModifTrainingPage extends StatefulWidget {
  final Session session;

  ModifTrainingPage({required this.session});

  @override
  _ModifTrainingPageState createState() => _ModifTrainingPageState();
}

class _ModifTrainingPageState extends State<ModifTrainingPage> {
  late Session currentSession;
  List<Exercise> exercises = [
    Exercise(
      id: 1,
      name: "Bench Press",
      description: "Chest exercise",
      image: "bench_press.png",
      category: Category(id: 1, title: 'Strength'),
      sets: [
        Set(id: 1, reps: 10, weight: [60, 70, 80], rest: Duration(seconds: 60), mode: 0),
        Set(id: 2, reps: 8, weight: [70, 80, 90], rest: Duration(seconds: 60), mode: 0),
      ],
    ),
    Exercise(
      id: 2,
      name: "Squat",
      description: "Leg exercise",
      image: "squat.png",
      category: Category(id: 1, title: 'Strength'),
      sets: [
        Set(id: 1, reps: 12, weight: [80, 90, 100], rest: Duration(seconds: 90), mode: 0),
        Set(id: 2, reps: 10, weight: [90, 100, 110], rest: Duration(seconds: 90), mode: 0),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    currentSession = widget.session;
  }

  void _showExerciceModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const ExercicesTab();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.black,
        backgroundColor: const Color(0xFF1B1B1B),
        title: SvgPicture.asset('assets/AthletiX.svg'),
        titleSpacing: -40,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: SizedBox(),
        ),
      ),
      body: Container(
        color: const Color(0xFF282828),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
                      child: Text(
                        currentSession.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    /*ListView.builder(
                      itemCount: exercises.length,
                      itemBuilder: (context, index) {
                        final exercise = exercises[index];
                        //return TrainingExercise(exercise: exercise);
                      },
                    ),*/
                    Column(
                      children: exercises.map((exercise) {
                        return TrainingExercise(exercise: exercise);
                      }).toList(),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          _showExerciceModal(context);
                        },
                        child: const Text(
                          'Add exercise',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}