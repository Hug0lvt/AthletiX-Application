import 'package:flutter/material.dart';
import '../components/buttonProfilePage.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
                      margin: const EdgeInsets.all(35.0),
                      constraints: BoxConstraints.expand(
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A).withOpacity(0.7),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Image en haut à droite dans le container
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset(
                                '../assets/EditIcon.png',
                                width: 25.0,
                                height: 25.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Text(
                            'Contenu de la nouvelle page',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'coucou',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '1',
                                    style: TextStyle(
                                      color: Colors.white,
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
                                    ),
                                  ),
                                  Text(
                                    '2',
                                    style: TextStyle(
                                      color: Colors.white,
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
                                    ),
                                  ),
                                  Text(
                                    '3',
                                    style: TextStyle(
                                      color: Colors.white,
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
                                    ),
                                  ),
                                  Text(
                                    '4',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Image en haut au centre
                    Positioned(
                      top: 0,
                      child: ClipOval(
                        child: Image.asset(
                          '../assets/EditIcon.png',
                          width: 78.0,
                          height: 78.0,
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
                      imagePath: '../assets/PostIcon.png',
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.07,
                    ),
                    ButtonProfilePage(
                      text: 'Mon bouton',
                      imagePath: '../assets/HeartIcon.png',
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.07,
                    ),
                    ButtonProfilePage(
                      text: 'Mon bouton',
                      imagePath: '../assets/StatisticsIcon.png',
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.07,
                    ),
                    ButtonProfilePage(
                      text: 'Mon bouton',
                      imagePath: '../assets/LogoAppIcon.png',
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.07,
                    ),
                    ButtonProfilePage(
                      text: 'Mon bouton',
                      imagePath: '../assets/SettingsIcon.png',
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.07,
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



