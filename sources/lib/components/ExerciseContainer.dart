import 'package:flutter/material.dart';

class ExerciseContainer extends StatelessWidget {
  final String icon;
  final String name;

  ExerciseContainer({
    required this.icon,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dynamicSpacing = screenWidth * 0.02;

    return GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Gesture Detected!')));
    },
    child:
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: screenWidth,
          decoration: ShapeDecoration(
            color: const Color(0xE51A1A1A),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2, color: Color(0xD7B56CFF)),
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image.asset(
                    icon,
                    height: 50,
                    width: 50,
                  ),
                ),
                SizedBox(width: dynamicSpacing),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.036,
                    fontFamily: 'Mulish',
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    ),
    );
  }
}
