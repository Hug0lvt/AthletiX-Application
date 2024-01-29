import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/buttonProfilePage.dart';
import '../components/editProfilContainer.dart';

class ProfilePrivatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
                  'Edit my profile',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.1,
                    fontFamily: 'Mulish',
                  ),
                ),
                EditProfileContainer(onClose: () {
                  Navigator.pop(context);
                }),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xFF363636),
          padding: const EdgeInsets.all(36),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      margin: const  EdgeInsets.symmetric(vertical: 35.0),
                      constraints: BoxConstraints.expand(
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A).withOpacity(0.7),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Pseudo',
                            style: TextStyle(
                              fontSize: screenWidth * 0.040,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: screenWidth * 0.3,
                            height: 1.0,
                            color: const Color(0xFF434343),
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'coucou',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.034,
                                    ),
                                  ),
                                  Text(
                                    '1',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.034,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'coucou',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.034,
                                    ),
                                  ),
                                  Text(
                                    '2',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.034,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'coucou',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.034,
                                    ),
                                  ),
                                  Text(
                                    '3',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.034,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'coucou',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.034,
                                    ),
                                  ),
                                  Text(
                                    '4',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.034,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 50.0,
                      right: 20.0,
                      child: IconButton(
                        onPressed: onPressed,
                        icon: SvgPicture.asset(
                          'assets/EditIcon.svg',
                          width: screenWidth * 0.034,
                          height: screenHeight * 0.034,
                        ),
                      ),
                    ),
                    // Image en haut au centre
                    Positioned(
                      top: 0,
                      child: ClipOval(
                        child: SvgPicture.asset(
                          'assets/EditIcon.svg',
                          width: 78,
                          height: 78,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonProfilePage(
                      text: 'Mon bouton',
                      imagePath: 'assets/PostIcon.svg',
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.07,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                    ),
                    ButtonProfilePage(
                      text: 'Mon bouton',
                      imagePath: 'assets/HeartIcon.svg',
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.07,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                    ),
                    ButtonProfilePage(
                      text: 'Mon bouton',
                      imagePath: 'assets/StatisticsIcon.svg',
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.07,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                    ),
                    ButtonProfilePage(
                      text: 'Mon bouton',
                      imagePath: 'assets/DoubleHaltereIcon.svg',
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.07,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                    ),
                    ButtonProfilePage(
                      text: 'Mon bouton',
                      imagePath: 'assets/SettingsIcon.svg',
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.07,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



