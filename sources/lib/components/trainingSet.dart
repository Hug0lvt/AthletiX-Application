import 'dart:async';
import 'package:flutter/material.dart';
import 'package:AthletiX/utils/appColors.dart';
import 'package:flutter_svg/svg.dart';
import '../model/set.dart';
import 'gradientButton.dart';

class TrainingSet extends StatefulWidget {
  final Set set;
  late int status;

  TrainingSet({Key? key, required this.set, required this.status}) : super(key: key);

  @override
  _TrainingSetState createState() => _TrainingSetState();
}

class _TrainingSetState extends State<TrainingSet> {
  late int _secondsElapsed;
  late Timer _timer;
  late TextEditingController _controllerRep;

  @override
  void initState() {
    //widget.status = 2;
    super.initState();
    _secondsElapsed = widget.set.rest.inSeconds;
    _controllerRep = TextEditingController(text: "${widget.set.reps}");
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_secondsElapsed > 0) {
          _secondsElapsed--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _decrementTimer() {
    setState(() {
      if (_secondsElapsed > 0) {
        _secondsElapsed = _secondsElapsed-10;
      }
    });
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
    setState(() {
      _secondsElapsed = _secondsElapsed+10;
    });
  }

  void _handleEditingComplete() {
    print("onSubmitted: $_controllerRep");
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Card(
      color: AppColors.greyMid,
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
                          child: Text(widget.set.weight.join(', '), style: const TextStyle(color: Colors.white)),
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
                              //onEditingComplete: _handleEditingComplete(),
                              controller: TextEditingController(text: "${widget.set.reps}") ,
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
                          onPressed: _decrementTimer,
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
                          onPressed: _incrementTimer,
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
    );
  }

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}
