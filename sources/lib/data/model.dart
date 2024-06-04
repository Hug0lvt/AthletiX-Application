import 'package:AthletiX/page/conversations.dart';
import 'package:AthletiX/page/home.dart';
import 'package:AthletiX/page/profilePrivate.dart';
import 'package:AthletiX/page/publishPost.dart';
import 'package:flutter/material.dart';

class Model {
  final int id;
  final String imagePath;
  final String name;
  final Widget page;

  Model({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.page,
  });
}


List<Model> navBtn = [
  Model(id: 0, imagePath: 'assets/video.png', name: 'Videos',page: HomePage()),
  Model(id: 1, imagePath: 'assets/search.png', name: 'Search', page: LicensePage()), // A modifier
  Model(id: 2, imagePath: 'assets/plus.png', name: 'New', page: PublishPostPage()),
  Model(id: 3, imagePath: 'assets/chat.png', name: 'Messages', page: ConversationPage()),
  Model(id: 4, imagePath: 'assets/person.png', name: 'Profile', page: ProfilePrivatePage()),
];