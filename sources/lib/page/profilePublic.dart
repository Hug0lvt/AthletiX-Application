import 'dart:convert';

import 'package:AthletiX/providers/api/clientApi.dart';
import 'package:AthletiX/providers/api/utils/postClientApi.dart';
import 'package:flutter/material.dart';
import '../components/profilePublicPostedCard.dart';
import '../components/sendMessage.dart';
import '../main.dart';
import '../model/post.dart';
import '../model/profile.dart';
import '../utils/appColors.dart';

class ProfilePublicPage extends StatefulWidget {
  final Profile profile;

  ProfilePublicPage({required this.profile});

  @override
  _ProfilePublicPageState createState() => _ProfilePublicPageState();
}

class _ProfilePublicPageState extends State<ProfilePublicPage> {
  final postsClientApi = getIt<PostClientApi>();
  List<Post> _posts = [];
  bool _isLoadingPosts = true;

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  Future<void> fetchVideos() async {
    try {
      List<Post> posts = await postsClientApi.getPostsByUser(widget.profile.id!.toString());
      setState(() {
        _posts = posts;
        _isLoadingPosts = false;
      });
    } catch (e) {
      print('Failed to load videos: $e');
      setState(() {
        _isLoadingPosts = false;
      });
    }
  }

  Widget _buildImage() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    try {
      if (widget.profile.picture!.isNotEmpty) {
        return Image.memory(
          base64Decode(widget.profile.picture!),
          fit: BoxFit.cover,
          width: screenWidth * 0.2,
          height: screenHeight * 0.2,
        );
      } else {
        throw Exception("Image is empty");
      }
    } catch (e) {
      return Image.network(
        "https://via.placeholder.com/80/3C383B/B66CFF?text=${widget.profile.username?.substring(0, 1)}",
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
                                  child: _buildImage(),
                                ),
                              ),
                              Text(
                                widget.profile.username ?? "Username indisponible",
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
                  child: _isLoadingPosts
                      ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                      : ListView.builder(
                    itemCount: _posts.length,
                    itemBuilder: (context, index) {
                      final post = _posts[index];
                      return ProfilePublicPostedCard(
                        postName: post.title ?? 'No Title',
                        description: post.description ?? 'No Description',
                        thumbnailUrl: post.thumbnail!,
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
      ),
    );
  }
}
