import 'package:flutter/material.dart';

class Program_Container extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          width: screenWidth,
          height: screenWidth * 0.37, // Adjust the height based on your design
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: screenWidth,
                  height: screenWidth * 0.37,
                  decoration: ShapeDecoration(
                    color: Color(0xE51A1A1A),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xFFB56CFF)),
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
                ),
              ),
              Positioned(
                left: screenWidth * 0.033,
                top: screenWidth * 0.02,
                child: SizedBox(
                  width: screenWidth * 0.57,
                  height: screenWidth * 0.08,
                  child: Text(
                    'Push',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.036,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: screenWidth * 0.033,
                top: screenWidth * 0.065,
                child: SizedBox(
                  width: screenWidth * 0.57,
                  height: screenWidth * 0.08,
                  child: Text(
                    'Last session : 10 days ago',
                    style: TextStyle(
                      color: Color(0xFFA1A1A1),
                      fontSize: screenWidth * 0.022,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: screenWidth * 0.032,
                top: screenWidth * 0.13,
                child: SizedBox(
                  width: screenWidth * 0.57,
                  height: screenWidth * 0.08,
                  child: Text(
                    '4 x 8 Dumbbell Benchpress',
                    style: TextStyle(
                      color: Color(0xFFA1A1A1),
                      fontSize: screenWidth * 0.012,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: screenWidth * 0.032,
                top: screenWidth * 0.16,
                child: SizedBox(
                  width: screenWidth * 0.57,
                  height: screenWidth * 0.08,
                  child: Text(
                    '4 x 8 Inclined Dumbbell Benchpress',
                    style: TextStyle(
                      color: Color(0xFFA1A1A1),
                      fontSize: screenWidth * 0.012,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: screenWidth * 0.032,
                top: screenWidth * 0.19,
                child: SizedBox(
                  width: screenWidth * 0.57,
                  height: screenWidth * 0.08,
                  child: Text(
                    '4 x 8 Machine Fly',
                    style: TextStyle(
                      color: Color(0xFFA1A1A1),
                      fontSize: screenWidth * 0.012,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: screenWidth * 0.032,
                top: screenWidth * 0.22,
                child: SizedBox(
                  width: screenWidth * 0.57,
                  height: screenWidth * 0.08,
                  child: Text(
                    '4 x 8 Cable Triceps',
                    style: TextStyle(
                      color: Color(0xFFA1A1A1),
                      fontSize: screenWidth * 0.012,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: screenWidth * 0.962,
                top: screenWidth * 0.043,
                child: Container(
                  width: screenWidth * 0.006,
                  height: screenWidth * 0.006,
                  decoration: ShapeDecoration(
                    color: Color(0xFFD9D9D9),
                    shape: CircleBorder(),
                  ),
                ),
              ),
              Positioned(
                left: screenWidth * 0.953,
                top: screenWidth * 0.043,
                child: Container(
                  width: screenWidth * 0.006,
                  height: screenWidth * 0.006,
                  decoration: ShapeDecoration(
                    color: Color(0xFFD9D9D9),
                    shape: CircleBorder(),
                  ),
                ),
              ),
              Positioned(
                left: screenWidth * 0.970,
                top: screenWidth * 0.043,
                child: Container(
                  width: screenWidth * 0.006,
                  height: screenWidth * 0.006,
                  decoration: ShapeDecoration(
                    color: Color(0xFFD9D9D9),
                    shape: CircleBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
