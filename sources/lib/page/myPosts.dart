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
  List<String> _thumbnails = [];
  bool _isLoadingProfile = true;

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    Profile? profile = await AuthManager.getProfile();
    setState(() {
      _profile = profile;
      _isLoadingProfile = false;
    });
    if (_profile != null) {
      fetchMyPosts();
    }
  }

  Future<void> fetchMyPosts() async {
    if (_profile?.id != null) {
      int profileId = _profile!.id!;
      String jsonReply = await _clientApi.getData('posts/user/$profileId?includeComments=true&includeExercises=true');
      Map<String, dynamic> data = json.decode(jsonReply);
      String jsonItems = json.encode(data["items"]);
      _posts = postFromJson(jsonItems) as List<Post>;
      _generateThumbnails();
    }
  }

  Future<void> _generateThumbnails() async {
    List<String> videoUrls = _posts.map((post) => post.content!).toList();
    List<String> thumbnails = await getThumbnails(videoUrls);
    setState(() {
      _thumbnails = thumbnails;
    });
  }

  Future<List<String>> getThumbnails(List<String> videoUrls) async {
    final tempDir = await getTemporaryDirectory();
    List<String> thumbnailPaths = [];

    for (String videoUrl in videoUrls) {
      final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: videoUrl,
        thumbnailPath: tempDir.path,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 100, // specify the height of the thumbnail, width is auto-scaled to keep aspect ratio
        quality: 75, // specify the quality of the thumbnail
      );
      thumbnailPaths.add(thumbnailPath ?? 'https://via.placeholder.com/800/3C383B/B66CFF?text=No+Thumbnail');
    }

    return thumbnailPaths;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: _isLoadingProfile
            ? Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : Container(
          color: const Color(0xFF363636),
          padding: const EdgeInsets.all(36),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                            if (startIndex < _posts.length)
                              ProfilePublicPostedCard(
                                postName: _posts[startIndex].title!,
                                description: _posts[startIndex].description!,
                                //postDate: _posts[startIndex].,
                                imagePath: _thumbnails.isNotEmpty ? _thumbnails[startIndex] : '',
                                width: screenWidth * 0.42,
                                height: screenHeight * 0.3,
                              ),
                            if (endIndex < _posts.length)
                              ProfilePublicPostedCard(
                                postName: _posts[endIndex].title!,
                                description: _posts[endIndex].description!,
                                //postDate: _posts[endIndex].,
                                imagePath: _thumbnails.isNotEmpty ? _thumbnails[endIndex] : '',
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
