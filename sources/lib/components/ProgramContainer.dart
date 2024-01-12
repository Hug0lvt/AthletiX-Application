import 'package:flutter/material.dart';

class ProgramContainer extends StatelessWidget {
  final String title;
  final List<String> exercises;
  final String lastSession;

  ProgramContainer({
    required this.title,
    required this.exercises,
    required this.lastSession,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    List<Widget> positionedWidgets = [];

    for (int i = 0; i < exercises.length; i++) {
      positionedWidgets.add(
        SizedBox(
          width: screenWidth * 0.57,
          child: Text(
            exercises[i],
            style: TextStyle(
              color: Color(0xFFA1A1A1),
              fontSize: screenWidth * 0.02,
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: screenWidth,
          decoration: ShapeDecoration(
            color: Color(0xE51A1A1A),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 2, color: Color(0xFFB56CFF)),
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: [
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
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.036,
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w700,
                  ),
                ),

                Text(
                  'Last session : '+ lastSession +' days ago',
                  style: TextStyle(
                    color: Color(0xFFA1A1A1),
                    fontSize: screenWidth * 0.022,
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: screenWidth * 0.02,
                ),
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: positionedWidgets,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8.0),
      ],
    );
  }
}