import 'package:AthletiX/page/TrainingHome.dart';
import 'package:AthletiX/page/conversations.dart';
import 'package:AthletiX/page/home.dart';
import 'package:AthletiX/page/publishPost.dart';
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
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    TrainingHome(),
    PublishPostPage(),
    ConversationPage(),
    ProfilePrivatePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.video_call_rounded),
            label: 'Video',
            backgroundColor: AppColors.greyDark,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_off_rounded),
            label: 'Search',
            backgroundColor: AppColors.greyDark,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Publish',
            backgroundColor: AppColors.greyDark,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
            backgroundColor: AppColors.greyDark,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
            backgroundColor: AppColors.greyDark,
          ),
        ],
      ),
    );
  }
}