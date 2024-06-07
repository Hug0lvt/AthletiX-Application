import 'dart:convert';

import 'package:AthletiX/providers/api/clientApi.dart';
import 'package:AthletiX/providers/api/utils/postClientApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../components/profilePublicPostedCard.dart';
import '../components/sendMessage.dart';
import '../main.dart';
import '../model/post.dart';
import '../model/profile.dart';
import '../providers/localstorage/secure/authManager.dart';

class MyPostPage extends StatefulWidget {
  @override
  _MyPostPageState createState() => _MyPostPageState();
}

class _MyPostPageState extends State<MyPostPage> {
  final postsClientApi = getIt<PostClientApi>();
  final _clientApi = getIt<ClientApi>();
  Profile? _profile;
  List<Post> _posts = [];
  @override
  void initState() {
    super.initState();
    fetchProfile();
    fetchMyPosts();
  }

  void fetchProfile() async {
    Profile? profile = await AuthManager.getProfile();
    setState(() {
      _profile = profile;
    });
  }

  void fetchMyPosts() async {
    if(_profile?.id != null) {
      int profileId = _profile!.id!;
      String jsonReply = await _clientApi.getData('posts/user/$profileId?includeComments=true&includeExercises=true');
      Map<String, dynamic> data = json.decode(jsonReply);
      String jsonItems = json.encode(data["items"]);
      _posts = postFromJson(jsonItems) as List<Post>;
    }
  }

  Future<String> getThumbnail(String videoUrl) async {
    final tempDir = await getTemporaryDirectory();
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: videoUrl,
      thumbnailPath: tempDir.path,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 100,
      quality: 75,
    );

    return thumbnailPath ?? 'https://via.placeholder.com/800/3C383B/B66CFF?text=${_profile!.username}';
  }

  String _generateThumbnail(String videoUrl) async {
    final thumbnailPath = await getThumbnail(videoUrl);
    return thumbnailPath;
  }

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
                                  child: _profile != null && _profile!.picture != null
                                      ? Image.network(
                                    _profile!.picture!,
                                    width: 78.0,
                                    height: 78.0,
                                    fit: BoxFit.cover,
                                  )
                                      : SvgPicture.asset(
                                    'assets/EditIcon.svg',
                                    width: 78.0,
                                    height: 78.0,
                                  ),
                                ),
                              ),
                              Text(
                                _profile != null ? _profile!.username! : 'Pseudo',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
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
                    itemCount: (_posts.length / 2).ceil(),
                    itemBuilder: (context, index) {
                      int startIndex = index * 2;
                      int endIndex = startIndex + 1;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ProfilePublicPostedCard(
                              postName: _posts[startIndex].title,
                              description: _posts[startIndex].description,
                              //postDate: _posts[startIndex].,
                              imagePath: await _generateThumbnail(_posts[startIndex].content),
                              width: screenWidth * 0.42,
                              height: screenHeight * 0.3,
                            ),
                            if (endIndex < _posts.length)
                              ProfilePublicPostedCard(
                                postName: _posts[startIndex].title,
                                description: _posts[startIndex].title,
                                //postDate: postData[endIndex]['postDate']!,
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
