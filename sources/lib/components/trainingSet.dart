import 'dart:async';
import 'package:flutter/material.dart';
import 'package:AthletiX/utils/appColors.dart';
import 'package:flutter_svg/svg.dart';
import '../main.dart';
import '../model/set.dart';
import '../providers/api/utils/setClientApi.dart';
import 'gradientButton.dart';

class TrainingSet extends StatefulWidget {
  late final Set set;
  late int status;
  late Function() isFinished;

  TrainingSet({Key? key, required this.set, required this.status, required this.isFinished}) : super(key: key);

  @override
  _TrainingSetState createState() => _TrainingSetState();
}

class _TrainingSetState extends State<TrainingSet> {
  late int _secondsElapsed;
  late Timer _timer;
  late TextEditingController _controllerRep;
  late TextEditingController _controllerWeight;
  final setClientApi = getIt<SetClientApi>();

  bool get _isDisabled => widget.status == 2 || widget.set.isDone;

  @override
  void initState() {
    super.initState();
    _secondsElapsed = widget.set.rest.inSeconds;
    _controllerRep = TextEditingController(text: "${widget.set.reps}");
    _controllerWeight = TextEditingController(text: widget.set.weight.join(', '));
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      /*setState(() {
        if (_secondsElapsed > 0) {
          _secondsElapsed--;
        } else {
          timer.cancel();
        }
      });*/
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controllerRep.dispose();
    _controllerWeight.dispose();
    super.dispose();
  }

  String _getModeText(int mode) {
    switch (mode) {
      case 0:
        return "Progressive";
      case 1:
        return "Degressive";
      case 2:
        return "Normal";
      default:
        return "Unknown";
    }
  }

  void _incrementTimer() {
    Set newSet = widget.set;
    setState(() {
      _secondsElapsed = _secondsElapsed+10;
    });
    newSet.rest = Duration( seconds: _secondsElapsed);
    _updateSet(newSet);
  }

  void _decrementTimer() {
    Set newSet = widget.set;
    setState(() {
      if (_secondsElapsed > 0) {
        _secondsElapsed = _secondsElapsed-10;
      }
    });
    newSet.rest = Duration( seconds: _secondsElapsed);
    _updateSet(newSet);
  }

  void _handleEditingRepComplete() {
    FocusScope.of(context).unfocus();
    Set newSet = widget.set;
    newSet.reps = int.parse(_controllerRep.text);
    _updateSet(newSet);

  }

  void _handleEditingWeightComplete() {
    FocusScope.of(context).unfocus();
    Set newSet = widget.set;
    newSet.weight = _controllerWeight.text.split(',').map((e) => int.parse(e.trim())).toList();
    _updateSet(newSet);
  }

  Future<void> _updateSet(Set newSet) async {
    try {
      Set setUpdated = await setClientApi.updateSet(widget.set.id, newSet);

      setState(() {
        widget.set.reps = setUpdated.reps;
        widget.set.mode = setUpdated.mode;
        widget.set.weight = setUpdated.weight;
        widget.set.rest = setUpdated.rest;
        widget.set.isDone = setUpdated.isDone;
      });
    } catch (e) {
      print("Error in the set's update : $e");
    }
  }



  Future<void> _markSetAsDone() async {
    widget.set.isDone = true;

    await _updateSet(widget.set);

    if (widget.isFinished != null) {
      await widget.isFinished();
    }
  }




  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Dismissible(
      key: Key(widget.set.id.toString()),
      direction: widget.status == 1 && !widget.set.isDone ? DismissDirection.endToStart : DismissDirection.none,
      confirmDismiss: (DismissDirection direction) async {
        if (direction == DismissDirection.endToStart) {
          await _markSetAsDone(); // Attendre que le set soit marqué comme terminé
          return false; // Retourner false pour ne pas supprimer l'élément (ou true si nécessaire)
        }
        return false;
      },
      background: Container(
        color: Colors.green,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.check, color: Colors.white),
      ),
      child :
     Card(
      color: widget.set.isDone ? Colors.grey.withOpacity(0.5) : AppColors.greyMid,
      margin: EdgeInsets.symmetric(
        vertical: screenHeight * 0.01,
        horizontal: screenWidth * 0.01,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.015,
        ),
        child: Column(
          children: [
            Table(
              columnWidths: const {
                0: FlexColumnWidth(0.15),
                1: FlexColumnWidth(0.3),
                2: FlexColumnWidth(0.3),
                3: FlexColumnWidth(0.15),
              },
              children: [
                const TableRow(
                  children: [
                    Center(child: Text("Set", style: TextStyle(color: Colors.white, fontSize: 16))),
                    Center(child: Text("Mode", style: TextStyle(color: Colors.white, fontSize: 16))),
                    Center(child: Text("Weight", style: TextStyle(color: Colors.white, fontSize: 16))),
                    Center(child: Text("Rep", style: TextStyle(color: Colors.white, fontSize: 16))),
                  ],
                ),
                TableRow(
                  children: [
                    SizedBox(height: screenHeight * 0.01),
                    SizedBox(height: screenHeight * 0.01),
                    SizedBox(height: screenHeight * 0.01),
                    SizedBox(height: screenHeight * 0.01),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Center(
                        child: Text("${widget.set.id}", style: const TextStyle(color: Colors.white)),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Center(
                        child: Container(
                          height: screenHeight * 0.05,
                          width: screenWidth * 0.3,
                          decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          alignment: Alignment.center,
                          child: widget.status == 2 || widget.set.isDone ? Text(
                            _getModeText(widget.set.mode),
                            style: const TextStyle(
                                color: Colors.orange
                            ),
                          ) : DropdownButton<int>(
                            value: widget.set.mode,
                            dropdownColor: AppColors.greyMid,
                            style: const TextStyle(color: Colors.orange),
                            items: const [
                              DropdownMenuItem(
                                value: 0,
                                child: Text("Progressive"),
                              ),
                              DropdownMenuItem(
                                value: 1,
                                child: Text("Degressive"),
                              ),
                              DropdownMenuItem(
                                value: 2,
                                child: Text("Normal"),
                              ),
                            ],
                            onChanged: (value) {
                              if (widget.status != 2 && !widget.set.isDone && value != null) {
                                setState(() {
                                  widget.set.mode = value;
                                  _updateSet(widget.set);
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Container(
                        height: screenHeight * 0.05,
                        width: screenWidth * 0.3,
                        decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        alignment: Alignment.center,
                        child: Center(
                          child: widget.status == 2 || widget.set.isDone ?
                          Text(
                              widget.set.weight.join(', '),
                              style: const TextStyle(color: Colors.white))
                          : TextField(
                            controller: _controllerWeight,
                            keyboardType: TextInputType.number,
                            onEditingComplete: _handleEditingWeightComplete,
                            decoration: const InputDecoration(
                              hintText: "0,0,0",
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: Container(
                        height: screenHeight * 0.05,
                        width: screenWidth * 0.0001,
                        decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        alignment: Alignment.center,
                        child: Center(
                          child: widget.status == 2 || widget.set.isDone ?
                          Text("${widget.set.reps}", style: const TextStyle(color: Colors.white)) :
                          TextField(
                            keyboardType: TextInputType.number,
                              onEditingComplete: () => _handleEditingRepComplete(),
                              controller: _controllerRep,
                              style: const TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Column(
              children: [
                const Text(
                  "Timer",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: GradientButton(
                          icon: SvgPicture.asset(
                            'assets/MinusIcon.svg',
                            width: screenWidth * 0.008,
                            height: screenHeight * 0.008,
                          ),
                          width: screenWidth * 0.3,
                          height: screenHeight * 0.06,
                          onPressed: _isDisabled ? null : _decrementTimer,
                        ),
                      ),
                      Container(
                        height: screenHeight * 0.06,
                        decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          formatTime(_secondsElapsed),
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: GradientButton(
                          icon: SvgPicture.asset(
                            'assets/AddIcon.svg',
                            width: screenWidth * 0.035,
                            height: screenHeight * 0.035,
                          ),
                          width: screenWidth * 0.3,
                          height: screenHeight * 0.06,
                          onPressed: _isDisabled ? null : _incrementTimer,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),);
  }

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}
