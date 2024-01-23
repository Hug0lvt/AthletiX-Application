import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/ExerciseContainer.dart';
import '../../components/FilterContainer.dart';

class ExercicesTab extends StatelessWidget {
  const ExercicesTab({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;


    void onPressed() {
      showModalBottomSheet<int>(
        showDragHandle: true,
        isScrollControlled: true,
        backgroundColor: Colors.black87,
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                Text(
                    'Filters',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.1,
                      fontFamily: 'Mulish',
                    ),
                  ),
                FilterContainer(
                    filters: ['Chest', 'Back', 'Arms', 'Legs', 'Abs', 'Biceps'],
                    color: Colors.white24,
                ),
            ],
            ),
          );
        },
      );
    }

    return Scaffold(
      body:
      Container(
        color: const Color(0xFF282828),
        child:
        Column(
          children: [
            const SizedBox(height: 8.0),
            Row( children: [
              Container(
                margin: EdgeInsets.fromLTRB(screenWidth * 0.045,0,screenWidth * 0.02,0),
                width: screenWidth * 0.8,
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
              IconButton(onPressed: onPressed, icon: SvgPicture.asset('assets/Filter.svg'), padding: EdgeInsets.fromLTRB(0, screenWidth * 0.01, screenWidth * 0.02, 0))
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 8.0),
                const Text(
                  'Exercises',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Mulish',
                  ),
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
                  ExerciseContainer(
                    name: 'Dumbbell Benchpress',
                    icon: 'assets/Benchpress.png'
                  ),
                  ExerciseContainer(
                      name: 'Dumbbell Benchpress',
                      icon: 'assets/Benchpress.png'
                  ),
                  ExerciseContainer(
                      name: 'Dumbbell Benchpress',
                      icon: 'assets/Benchpress.png'
                  ),
                  ExerciseContainer(
                      name: 'Dumbbell Benchpress',
                      icon: 'assets/Benchpress.png'
                  ),ExerciseContainer(
                      name: 'Dumbbell Benchpress',
                      icon: 'assets/Benchpress.png'
                  ),ExerciseContainer(
                      name: 'Dumbbell Benchpress',
                      icon: 'assets/Benchpress.png'
                  ),ExerciseContainer(
                      name: 'Dumbbell Benchpress',
                      icon: 'assets/Benchpress.png'
                  ),ExerciseContainer(
                      name: 'Dumbbell Benchpress',
                      icon: 'assets/Benchpress.png'
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
