import 'package:AthletiX/model/practicalExercise.dart';
import 'package:flutter/material.dart';

class ProgramContainer extends StatelessWidget {
  final String title;
  final List<PracticalExercise> exercises;
  final String lastSession;
  final VoidCallback? onDelete;

  ProgramContainer({
    required this.title,
    required this.exercises,
    required this.lastSession,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    List<Widget> positionedWidgets = [];

    for (int i = 0; i < exercises.length; i++) {
      String buildExercice = "${exercises[i].sets.length} x ${exercises[i].sets[0].reps} ${exercises[i].name}";
      positionedWidgets.add(
        SizedBox(
          width: screenWidth * 0.57,
          child: Text(
            buildExercice,
            style: TextStyle(
              color: const Color(0xFFA1A1A1),
              fontSize: screenWidth * 0.03,
              fontFamily: 'Mulish',
            ),
          ),
        ),
      );
    }

    final kGradientBoxDecoration = BoxDecoration(
      boxShadow: const [
        BoxShadow(
          color: Color(0x3F000000),
          blurRadius: 4,
          offset: Offset(0, 4),
          spreadRadius: 0,
        ),
      ],
      gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFB66CFF), Color(0xFFA2E4E6)]),
      borderRadius: BorderRadius.circular(10),
    );

    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gesture Detected!')));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: kGradientBoxDecoration,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                width: screenWidth * 0.97,
                decoration: ShapeDecoration(
                  color: const Color(0xE51A1A1A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.05,
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (onDelete != null)
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.white),
                              onPressed: onDelete,
                            ),
                        ],
                      ),
                      Text(
                        'Last session : $lastSession',
                        style: TextStyle(
                          color: const Color(0xFFA1A1A1),
                          fontSize: screenWidth * 0.03,
                          fontFamily: 'Mulish',
                        ),
                      ),
                      SizedBox(
                        height: screenWidth * 0.02,
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: positionedWidgets,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
