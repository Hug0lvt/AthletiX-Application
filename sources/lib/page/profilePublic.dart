import 'package:flutter/material.dart';
import 'package:sources/components/profilePublicPostedCard.dart';
import '../components/sendMessage.dart';

class ProfilePublicPage extends StatelessWidget {
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
                      margin: const EdgeInsets.symmetric(vertical: 15.0),
                      constraints: BoxConstraints.expand(
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.13,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A).withOpacity(0.7),
                        borderRadius: BorderRadius.circular(35.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20, right: 10),
                                child: ClipOval(
                                  child: Image.asset(
                                    '../assets/EditIcon.png',
                                    width: 78.0,
                                    height: 78.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const Text(
                                'Pseudo',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                          ]
                          ),
                          SendMessage(
                            text: 'Message',
                            width: screenWidth * 0.25,
                            height: screenHeight * 0.05,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProfilePublicPostedCard(
                      postName: 'Name post',
                      description: 'Lorem ipsum sdjfhvb sdjfbhjbse kjfsku dfub isdbdsiuifb skdf ...',
                      postDate: 'Posted 21/09/2023 at 22:46',
                      imagePath: '../assets/EditIcon.png',
                      width: screenWidth * 0.45,
                      height: screenHeight * 0.3,
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



