import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/ProgramContainer.dart';

class TrainingTab extends StatelessWidget {
  const TrainingTab({super.key});

  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body:
      Container(
        color: Color(0xFF282828),
        child:
        Column(
          children: [
            const SizedBox(height: 8.0),
            SizedBox(
              width: screenWidth * 0.9,
              child: Stack(
                children: [
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                      ),
                      filled: true,
                      fillColor: const Color(0xFF1A1A1A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0), // Adjust padding as needed
                        child: SvgPicture.asset(
                          'assets/MagGlass.svg',
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 8.0),
                const Text(
                  'My Training Programs',
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
                IconButton(onPressed: onPressed, icon: SvgPicture.asset('assets/AddPlus.svg'),)
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
