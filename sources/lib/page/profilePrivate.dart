import 'dart:convert';
import 'dart:typed_data';

import 'package:AthletiX/constants/color.dart';
import 'package:AthletiX/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/buttonProfilePage.dart';
import '../components/editProfilContainer.dart';
import '../model/profile.dart';
import 'package:AthletiX/providers/localstorage/secure/authManager.dart';

class ProfilePrivatePage extends StatefulWidget {
  @override
  _ProfilePrivatePageState createState() => _ProfilePrivatePageState();
}

class _ProfilePrivatePageState extends State<ProfilePrivatePage> {
  Profile? _profile;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  void fetchProfile() async {
    // Call your method to fetch the profile
    Profile? profile = await AuthManager.getProfile();

    setState(() {
      _profile = profile;
      _isLoading = false;
    });
  }

  Widget _buildImage(double screenWidth, double screenHeight) {
    try {
      if (_profile!.picture!.isNotEmpty) {
        return Image.memory(
          base64Decode(_profile!.picture!),
          fit: BoxFit.cover,
          width: screenWidth * 0.20,
          height: screenWidth * 0.20,
        );
      } else {
        throw Exception("Image is empty");
      }
    } catch (e) {
      return Image.network("https://via.placeholder.com/${screenWidth * 0.20 }/3C383B/B66CFF?text=${_profile?.username?.substring(0,1)}",
        fit: BoxFit.cover,);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    Widget _buildProfileImage(double screenWidth) {
      if (_profile?.picture == null || _profile!.picture!.isEmpty || _profile!.picture! == "string") {
        return _buildImage(screenWidth, screenHeight);
      } else {
        Uint8List _imageBytes = base64Decode(_profile!.picture!);
        return Image.memory(
          _imageBytes,
          width: screenWidth * 0.20,
          height: screenWidth * 0.20,
          fit: BoxFit.cover,
        );
      }
    }

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
                  'Edit profile',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.07,
                    fontFamily: 'Mulish',
                  ),
                ),
                EditProfileContainer(onClose: () {
                  Navigator.pop(context);
                  fetchProfile();
                }),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: AppColors.greyDark,
      body: SafeArea(
        child: _isLoading // Afficher l'indicateur de chargement si _isLoading est vrai
            ? Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : SingleChildScrollView(
          child: Container(
            color: AppColors.greyDark,
            padding: const EdgeInsets.all(36),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 40, 0, 10),
                        constraints: BoxConstraints.expand(
                          width: screenWidth * 0.9,
                          height: screenHeight * 0.2,
                        ),
                        decoration: BoxDecoration(
                            color: const Color(0xFF1A1A1A).withOpacity(0.7),
                            borderRadius: BorderRadius.circular(25.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _profile?.username.toString() ?? 'Unknown',
                              style: TextStyle(
                                fontSize: ((screenWidth + screenHeight) / 2) * 0.040,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              width: screenWidth * 0.3,
                              height: 1.0,
                              color: const Color(0xFF434343),
                              margin: const EdgeInsets.symmetric(vertical: 5.0),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Gender',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.034,
                                      ),
                                    ),
                                    Text(
                                      _profile!.gender! ? "Male" : "Female",
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
                                      'Age',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.034,
                                      ),
                                    ),
                                    Text(
                                      _profile?.age.toString() ?? 'Unknown',
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
                                      'Height',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.034,
                                      ),
                                    ),
                                    Text(
                                      (_profile?.height.toString() ?? '0') + ' cm',
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
                                      'Weight',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.034,
                                      ),
                                    ),
                                    Text(
                                      (_profile?.weight.toString() ?? '0') + ' kg',
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
                        child: ClipOval(child: _buildProfileImage(screenWidth)),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ButtonProfilePage(
                        text: 'Posts',
                        imagePath: 'assets/PostIcon.svg',
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.07,
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                      ),
                      ButtonProfilePage(
                        text: 'Favorite Posts',
                        imagePath: 'assets/HeartIcon.svg',
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.07,
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                      ),
                      ButtonProfilePage(
                        text: 'Statistics',
                        imagePath: 'assets/StatisticsIcon.svg',
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.07,
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                      ),
                      ButtonProfilePage(
                        text: 'Exercises',
                        imagePath: 'assets/DoubleHaltereIcon.svg',
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.07,
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                      ),
                      ButtonProfilePage(
                        text: 'Settings',
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
      ),
    );
  }
}
