import 'package:AthletiX/components/trainingExercise.dart';
import 'package:AthletiX/model/exercise.dart';
import 'package:AthletiX/model/session.dart';
import 'package:AthletiX/page/trainingTabs/ExercicesTab.dart';
import 'package:AthletiX/providers/api/utils/practicalexerciseClientApi.dart';
import 'package:AthletiX/providers/api/utils/sessionClientApi.dart';
import 'package:AthletiX/providers/api/utils/setClientApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../exceptions/not_found_exception.dart';
import '../main.dart';
import '../model/practicalExercise.dart';
import '../model/set.dart';

class ModifTrainingPage extends StatefulWidget {
  final Session session;
  final Function(bool)? onBack;

  ModifTrainingPage({required this.session, this.onBack});

  @override
  _ModifTrainingPageState createState() => _ModifTrainingPageState();
}

class _ModifTrainingPageState extends State<ModifTrainingPage> {
  late Session? currentSession;
  final practicalExerciseClientApi = getIt<PracticalExerciseClientApi>();
  final sessionClientApi = getIt<SessionClientApi>();
  final setClientApi = getIt<SetClientApi>();
  bool isLoading = false;

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

  void _stopTraining() async {
    await sessionClientApi.deleteSession(currentSession!.id!);
    Navigator.pop(
      context,
    );
  }

  void _isFinish() async {
    bool allSetsDone = true;
    List<Future<void>> futuresEx = currentSession!.exercises.map((exo) async {
      PracticalExercise exToAdd = await practicalExerciseClientApi.getPracticalExerciseById(exo.id);
      exToAdd.sets.isNotEmpty ? exToAdd.sets.map((set) async {
        if (!set.isDone) {
          allSetsDone = false;
          return;
        }
      }).toList() : allSetsDone = false;
    }).toList();

    await Future.wait(futuresEx);

    if (!allSetsDone) {
      return;
    } else {
      Session newSession = currentSession!;
      newSession.status = 2;

      await sessionClientApi.updateSession(currentSession!.id!, newSession);
      Navigator.pop(
        context,
      );
    }

  }

  void _startTraining() async {
    if (currentSession!.exercises.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No exercise !")));
      return;
    }

    Session sessionStarted = await sessionClientApi.getSessionById(currentSession!.id!);
    print(sessionStarted.exercises.first.exercise.name);


    sessionStarted.status = 1;
    sessionStarted.id = 0;
    print("sessionStarted.status");
    print(sessionStarted.status);

    Session sessionIntermediaire = await sessionClientApi.createSession(sessionStarted);

    List<Future<void>> futuresEx = sessionStarted.exercises.map((exo) async {
      print(exo.exercise.name);
      PracticalExercise exToAdd = await practicalExerciseClientApi.getPracticalExerciseById(exo.id);
      print(exToAdd.id);
      PracticalExercise currentEx = await practicalExerciseClientApi.createPracticalExercise(sessionIntermediaire.id!, exToAdd.exercise.id);
      exToAdd.sets.map((set) async {
        Set setToAdd = set;
        setToAdd.id = 0;
        await setClientApi.createSet(setToAdd, currentEx.id);
      }).toList();
    }).toList();

    await Future.wait(futuresEx);

    Session duplicatedSession = await sessionClientApi.getSessionById(sessionIntermediaire.id!);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ModifTrainingPage(session: duplicatedSession, onBack: widget.onBack,)),
    );


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

    return PopScope(
      canPop: true,
      onPopInvoked: widget.onBack,
      child:
      Scaffold(
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

                          Spacer(),
                          if (currentSession!.status == 0) ...[
                            TextButton(
                              onPressed: () {
                                // Action du bouton Start
                                _startTraining();
                              },
                              child: Text(
                                'Start',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ] else if (currentSession!.status == 1) ...[
                            TextButton(
                              onPressed: () {
                                // Action du bouton Stop
                                _stopTraining();
                              },
                              child: Text(
                                'Stop',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Column(
                      children: currentSession!.exercises.map((exercise) {
                        return TrainingExercise(
                          exercise: exercise,
                          status: currentSession!.status,
                          onDelete: () => _onDeleteExercise(exercise),
                          isFinished: () => _isFinish(),);
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
    ),
    );
  }

}