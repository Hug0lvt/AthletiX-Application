import 'dart:convert';

import 'package:flutter/material.dart';

import '../components/profilePublicPostedCard.dart';
import '../components/sendMessage.dart';
import '../model/profile.dart';
import '../utils/appColors.dart';

class ProfilePublicPage extends StatelessWidget {
  final Profile profile;

  ProfilePublicPage({required this.profile});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    List<Map<String, String>> postData = [
      {
        'postName': 'Name post 1',
        'description': 'Lorem ipsum sdjfhvb sdjfbhjbse kjfsku dfub isdbdsiuifb skdf ...',
        'postDate': 'Posted 21/09/2023 at 22:46',
        'imagePath': 'assets/EditIcon.svg',
      },
      {
        'postName': 'Name post 2',
        'description': 'Another description...',
        'postDate': 'Posted 22/09/2023 at 12:30',
        'imagePath': 'assets/EditIcon.svg',
      },
      {
        'postName': 'Name post 3',
        'description': 'Another description...',
        'postDate': 'Posted 22/09/2023 at 12:30',
        'imagePath': 'assets/EditIcon.svg',
      },
      {
        'postName': 'Name post 4',
        'description': 'Another description...',
        'postDate': 'Posted 22/09/2023 at 12:30',
        'imagePath': 'assets/EditIcon.svg',
      },

    ];

    Widget _buildImage() {
      try {
        if (profile.picture!.isNotEmpty) {
          return Image.memory(
            base64Decode(profile.picture!),
            fit: BoxFit.cover,
            width: screenWidth * 0.2,
            height: screenHeight * 0.2,
          );
        } else {
          throw Exception("Image is empty");
        }
      } catch (e) {
        return Image.network("https://via.placeholder.com/80/3C383B/B66CFF?text=${profile.username?.substring(0,1)}",
          fit: BoxFit.cover,);
      }
    }

    return Scaffold(
      backgroundColor: AppColors.greyDark,
      body: SafeArea(
        child: Container(
          color: AppColors.greyDark,
          padding: const EdgeInsets.all(20),
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
                                  child: _buildImage()
                                ),
                              ),
                            Text(
                              profile.username ?? "Username indisponible",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            ],
                          ),
                          SendMessage(
                            width: screenWidth * 0.20,
                            height: screenHeight * 0.05,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1.0,
                        color: const Color(0xFFFFFFFF),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: const Text(
                        'Posts',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1.0,
                        color: const Color(0xFFFFFFFF),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: (postData.length / 2).ceil(),
                    itemBuilder: (context, index) {
                      int startIndex = index * 2;
                      int endIndex = startIndex + 1;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ProfilePublicPostedCard(
                              postName: postData[startIndex]['postName']!,
                              description: postData[startIndex]['description']!,
                              postDate: postData[startIndex]['postDate']!,
                              imagePath: postData[startIndex]['imagePath']!,
                              width: screenWidth * 0.42,
                              height: screenHeight * 0.3,
                            ),
                            if (endIndex < postData.length)
                              ProfilePublicPostedCard(
                                postName: postData[endIndex]['postName']!,
                                description: postData[endIndex]['description']!,
                                postDate: postData[endIndex]['postDate']!,
                                imagePath: postData[endIndex]['imagePath']!,
                                width: screenWidth * 0.42,
                                height: screenHeight * 0.3,
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
