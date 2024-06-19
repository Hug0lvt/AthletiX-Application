import 'package:AthletiX/components/trainingSet.dart';
import 'package:flutter/cupertino.dart';
import 'package:AthletiX/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../exceptions/not_found_exception.dart';
import '../main.dart';
import '../model/exercise.dart';
import '../model/practicalExercise.dart';
import '../model/set.dart';
import '../providers/api/utils/practicalexerciseClientApi.dart';
import '../providers/api/utils/setClientApi.dart';

class TrainingExercise extends StatefulWidget {
  late PracticalExercise exercise;
  late int status;
  late VoidCallback? onDelete;
  late Function() isFinished;

  TrainingExercise({Key? key, required this.exercise, required this.status, required this.onDelete, required this.isFinished}) : super(key: key);

  @override
  _TrainingExerciseWidgetState createState() => _TrainingExerciseWidgetState();
}

class _TrainingExerciseWidgetState extends State<TrainingExercise> {

  final practicalExerciseClientApi = getIt<PracticalExerciseClientApi>();
  final setClientApi = getIt<SetClientApi>();
  PracticalExercise? currentExercice;
  bool isLoading = false;

  @override
  void initState() {
    currentExercice = null;
    WidgetsBinding.instance.addPostFrameCallback((_){
      _loadExercice();
    });
    super.initState();
  }

  void _loadExercice() async {
    setState(() {
      isLoading = true;
    });
    try {
      currentExercice = await practicalExerciseClientApi.getPracticalExerciseById(widget.exercise.id);
      setState(() {
        isLoading = false;
      });
    } on NotFoundException catch (_) {
      setState(() {
        isLoading = false;
      });
    }
  }

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


    setState(() {
      widget.exercise = newPracticalExercise;
      _loadExercice();
    });

  }

  void _showDeleteConfirmationDialog(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Set ?'),
          content: const Text('Are you sure you want to delete this set ?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                _deleteSet(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteSet(int id) async {
    setState(() {
      isLoading = true;
    });

    try {
      await setClientApi.deleteSet(id);
      setState(() {
        _loadExercice();
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
    return currentExercice == null
        ? Container()
        : SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            child: Row(
              children: [
                Text(
                  currentExercice!.exercise.name,
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
                widget.status == 0 ?
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.white),
                  onPressed: widget.onDelete,
                ) : Container(),
              ],
            ),
          ),
          isLoading
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : currentExercice != null
              ? Column(
            children: currentExercice!.sets.map((set) {
              return GestureDetector(
                  onLongPress: widget.status == 0 || (widget.status == 1 && !set.isDone) ?  () => _showDeleteConfirmationDialog(set.id) : null,
                  child: TrainingSet(
                set: set,
                isFinished: () => widget.isFinished(),
                status: currentExercice!.session!.status,
              ) );
            }).toList(),
          )
              : const Center(
            child: Text(
              'No session',
              style: TextStyle(color: Colors.white),
            ),
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
      ) ,
    );
  }
}