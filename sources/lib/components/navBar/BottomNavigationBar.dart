import 'package:AthletiX/constants/color.dart';
import 'package:AthletiX/constants/text_style.dart';
import 'package:AthletiX/data/model.dart';
import 'package:AthletiX/page/TrainingHome.dart';
import 'package:AthletiX/page/conversations.dart';
import 'package:AthletiX/page/home.dart';
import 'package:AthletiX/page/publishPost.dart';
import 'package:AthletiX/widgets/custom_paint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../page/profilePrivate.dart';
import '../../utils/appColors.dart';

class DefaultBottomNavigationBar extends StatefulWidget {
  const DefaultBottomNavigationBar({super.key});

  @override
  State<DefaultBottomNavigationBar> createState() =>
      _DefaultBottomNavigationBarState();
}

class _DefaultBottomNavigationBarState extends State<DefaultBottomNavigationBar> {
  int selectBtn = 0;
  bool isFabActive = false;
  double screenWidth = 0;
  double screenHeight = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: navigationBar(),
          ),
          Positioned(
            bottom: screenHeight * 0.15 - 30,
            left: screenWidth / 1.1 - 30, // Center the FAB horizontally
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isFabActive = true;
                });
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: appBlackColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 15,
                    ),

                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      fadeCyan.withOpacity(0.5),
                      appBlackColor,
                      fadePurple.withOpacity(0.5), // Inner shadow color bottom right
                    ],
                  ),
                ),
                child: Center(
                  child: Transform.translate(
                    offset: const Offset(0, 4),
                    child: Image.asset(
                      'assets/dumbbell.png',
                      scale: screenWidth * 0.0035,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer navigationBar() {
    return AnimatedContainer(
      height: screenHeight * 0.08,
      duration: const Duration(milliseconds: 100),
      decoration: BoxDecoration(
        color: appBlackColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(selectBtn == 0 ? 0.0 : 20.0),
          topRight: Radius.circular(selectBtn == navBtn.length - 1 ? 0.0 : 20.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < navBtn.length; i++)
            GestureDetector(
              onTap: () => setState(() {
                selectBtn = i;
                isFabActive = false;  // Reset FAB active state when other buttons are clicked
              }),
              child: iconBtn(i),
            ),
        ],
      ),
    );
  }

  final Gradient textGradient = const LinearGradient(
    colors: <Color>[fadeCyan, fadePurple],
  );

  SizedBox iconBtn(int i) {
    bool isActive = selectBtn == i && !isFabActive;
    var height = isActive ? 60.0 : 0.0;
    var width = isActive ? 60.0 : 0.0;
    return SizedBox(
      width: screenWidth * 0.2,
      child: Stack(
        children: [
          if (isActive)
            Align(
              alignment: Alignment.topCenter,
              child: AnimatedContainer(
                height: height,
                width: width,
                duration: const Duration(milliseconds: 300),
                child: CustomPaint(
                  painter: ButtonNotch(),
                ),
              ),
            ),
          Align(
            alignment: Alignment.center,
            child: Transform.translate(
              offset: isActive ? Offset(0, 7) : Offset(0, 0), // Offset by 7 pixels down when active
              child: Image.asset(
                navBtn[i].imagePath,
                scale: screenWidth * 0.003,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
