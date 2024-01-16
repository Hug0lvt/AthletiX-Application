import 'package:flutter/material.dart';

import '../../components/ProgramContainer.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        color: const Color(0xFF282828),
        child:
        Column(
          children: [
            const SizedBox(height: 8.0),
            Row(
              children: [
                const SizedBox(width: 8.0),
                const Text(
                  'Training History',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Mulish',),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    height: 1.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView(
                shrinkWrap: true,
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
