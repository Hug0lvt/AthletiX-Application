import 'package:AthletiX/providers/api/clientApi.dart';
import 'package:AthletiX/providers/api/utils/postClientApi.dart';
import 'package:flutter/material.dart';
import '../components/profilePublicPostedCard.dart';
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
  Profile? _profile;
  List<Post> _posts = [];
  bool _isLoadingProfile = true;

  @override
  void initState() {
    super.initState();
    fetchData();

  }

  Future<void> fetchData() async {
    try {
      Profile? profile = await AuthManager.getProfile();
      setState(() {
        _profile = profile;
        _isLoadingProfile = false;
      });
      fetchVideos();
    } catch (e) {
      print("Error fetching profile: $e");
    }
  }

  Future<void> fetchVideos() async {
    try {
      List<Post> posts = await postsClientApi.getPostsByUser(_profile!.id!.toString());
      setState(() {
        _posts = posts;
      });
    } catch (e) {
      print('Failed to load videos: $e');
    }
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
          child: Column(
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
                  itemCount: _posts.length,
                  itemBuilder: (context, index) {
                    final post = _posts[index];
                    return ProfilePublicPostedCard(
                      postName: post.title ?? 'No Title',
                      description: post.description ?? 'No Description',
                      thumbnailUrl: post.thumbnail!, // Pass video URL to the card
                      width: screenWidth * 0.6,
                      height: screenHeight * 0.3,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}