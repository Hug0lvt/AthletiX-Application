import 'package:flutter/material.dart';

import '../../components/ProgramContainer.dart';

class HistoryTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        color: Color(0xFF282828),
        child:
        Column(
          children: [
            SizedBox(height: 8.0),
            Row(
              children: [
                SizedBox(width: 8.0),
                Text(
                  'Training History',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    height: 1.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ProgramContainer(
                    title: 'Push',
                    lastSession: '19',
                    exercises: [
                      '4 x 8 Dumbbell Benchpress',
                      '4 x 8 Inclined Dumbbell Benchpress',
                      '4 x 8 Machine Fly',
                      '4 x 8 Cable Triceps',
                    ],
                  ),
                  ProgramContainer(
                    title: 'Pull',
                    lastSession: '1',
                    exercises: [
                      '4 x 8 Pull-ups',
                      '4 x 8 Barbell Rows',
                      '4 x 8 Lat Pulldowns',
                      '4 x 8 Face Pulls',
                    ],
                  ),
                  // Add more ProgramContainer widgets as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
