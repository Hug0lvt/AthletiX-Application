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
    });
  }

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
                      margin: const  EdgeInsets.symmetric(vertical: 15.0),
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
                      child: ClipOval(
                        child: SvgPicture.asset(
                          'assets/EditIcon.svg',
                          width: screenWidth * 0.08,
                          height: screenHeight * 0.08,
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
    );
  }


}
