import 'package:AthletiX/constants/color.dart';
import 'package:AthletiX/data/model.dart';
import 'package:AthletiX/page/TrainingHome.dart';
import 'package:AthletiX/page/home.dart';
import 'package:AthletiX/utils/appColors.dart';
import 'package:AthletiX/widgets/custom_paint.dart';
import 'package:flutter/material.dart';

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
  Widget selectedPage = HomePage();

  @override
  Widget build(BuildContext context) {
    selectedPage = isFabActive ? TrainingHome() : navBtn.elementAt(selectBtn).page; // Added condition to select TrainingHome if FAB is active
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: AppColors.greyDark,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Center(
                    child: selectedPage,
                  ),
                  Positioned(
                    bottom: screenHeight * 0.05 - 30,
                    left: screenWidth / 1.1 - 30,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isFabActive = true;
                          selectedPage = TrainingHome();
                          print('FAB tapped, isFabActive: $isFabActive, selectedPage: $selectedPage'); // Debug statement
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
                              spreadRadius: 1,
                              blurRadius: 10,
                            ),
                          ],
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
            ),
            navigationBar(),
          ],
        ),
      ),
    );
  }

  AnimatedContainer navigationBar() {
    return AnimatedContainer(
      width: screenWidth,
      height: screenHeight * 0.08,
      duration: const Duration(milliseconds: 300),
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
                isFabActive = false;  // Reset FAB active state when other buttons are clicked
                selectBtn = i;
                selectedPage = navBtn.elementAt(i).page;
                print('Nav button $i tapped, isFabActive: $isFabActive, selectedPage: $selectedPage'); // Debug statement
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
              offset: isActive ? const Offset(0, 7) : const Offset(0, 0), // Offset by 7 pixels down when active
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
