import 'package:AthletiX/components/gradientButton.dart';
import 'package:AthletiX/components/sendMessage.dart';
import 'package:AthletiX/components/trainingExercise.dart';
import 'package:AthletiX/model/exercise.dart';
import 'package:AthletiX/model/session.dart';
import 'package:AthletiX/page/trainingTabs/ExercicesTab.dart';
import 'package:AthletiX/providers/api/utils/practicalexerciseClientApi.dart';
import 'package:AthletiX/providers/api/utils/sessionClientApi.dart';
import 'package:AthletiX/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../exceptions/not_found_exception.dart';
import '../main.dart';
import '../model/category.dart';
import '../model/practicalExercise.dart';
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
  late Session? currentSession;
  final practicalExerciseClientApi = getIt<PracticalExerciseClientApi>();
  final sessionClientApi = getIt<SessionClientApi>();
  bool isLoading = false;
  /*List<PracticalExercise> exercises = [
    PracticalExercise(
      id: 1,
      sets: [
        Set(id: 1, reps: 10, weight: [60, 70, 80], rest: Duration(seconds: 60), mode: 0),
        Set(id: 2, reps: 8, weight: [70, 80, 90], rest: Duration(seconds: 60), mode: 0),
      ],
      exercise: Exercise(
        id: 1
      ),
      session: null,
    ),
    PracticalExercise(
      id: 2,
      sets: [
        Set(id: 1, reps: 12, weight: [80, 90, 100], rest: Duration(seconds: 90), mode: 0),
        Set(id: 2, reps: 10, weight: [90, 100, 110], rest: Duration(seconds: 90), mode: 0),
      ],
      exercise: null,
      session: null,
    ),
  ];*/
  //List<PracticalExercise> exercises = [];

  @override
  void initState() {
    currentSession = null;
    isLoading = false;
    super.initState();
    currentSession = widget.session;
    //print(currentSession!.exercises.first.exercise.name);
    /*WidgetsBinding.instance.addPostFrameCallback((_){
      _loadSession();
    });*/
  }

  void _loadSession() async {
    setState(() {
      isLoading = true;
    });

    try {
      Session session = await sessionClientApi.getSessionById(widget.session.id!);
      setState(() {
        currentSession = session;
        isLoading = false;
      });
    } on NotFoundException catch (_) {
      setState(() {
        isLoading = false;
        currentSession = null;
      });
    }

  }

  void _addExercise(Exercise exercise) async {
    print(exercise.id);
    print(currentSession!.id);
    PracticalExercise practicalExercise = await practicalExerciseClientApi.createPracticalExercise(currentSession!.id!, exercise.id);
    setState(() {
      currentSession!.exercises.add(practicalExercise);
    });
  }

  void _startTraining() async {
    currentSession!.status = 1;

    setState(() {
      sessionClientApi.updateSession(currentSession!.id!, currentSession!);
    });


  }

  void _showExerciceModal(BuildContext context) {
    showModalBottomSheet<Exercise>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black87,
      builder: (context) => ExercicesTab(onExerciseSelected: (exercise) {
        Navigator.pop(context, exercise);
      }),
    ).then((selectedExercise) {
      if (selectedExercise != null) {
        _addExercise(selectedExercise);
      }
    });
  }

  void _onDeleteExercise(PracticalExercise exo) async {
    setState(() {
      isLoading = true;
    });

    print("delete exo");

    try {
      await practicalExerciseClientApi.deletePracticalExercise(exo.id);
      setState(() {
        _loadSession();
        currentSession!.exercises.remove(exo);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
                )
              : currentSession == null
            ? const Text('No session has been found')
            : Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text(
                            currentSession!.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),

                          if (currentSession!.status == 0 || currentSession!.status == 1)
                          Spacer(),
                            TextButton(
                              onPressed: () {
                                // Action du bouton
                                _startTraining();
                              },
                              child: Text('Start', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            ),
                            //),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Column(
                      children: currentSession!.exercises.map((exercise) {
                        return TrainingExercise(exercise: exercise, status: currentSession!.status, onDelete: () => _onDeleteExercise(exercise),);
                      }).toList(),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: currentSession?.status == 0 ? TextButton(
                        onPressed: () {
                          _showExerciceModal(context);
                        },
                        child: const Text(
                          'Add exercise',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ) : Container(),
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