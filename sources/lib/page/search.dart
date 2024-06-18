import 'package:AthletiX/components/UserCard.dart';
import 'package:AthletiX/components/profilePublicPostedCard.dart';
import 'package:AthletiX/model/post.dart';
import 'package:AthletiX/model/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchQuery = '';
  bool isPostsTab = true;
  List<Post> posts = [Post(id: 0), Post(id: 1), Post(id: 2)]; // Replace with actual data
  List<Profile> users = [Profile(), Profile(), Profile()]; // Replace with actual data

  void _onSearchChanged(String value) {
    setState(() {
      searchQuery = value;
      // Apply search logic here
    });
  }

  void _toggleTab(bool isPosts) {
    setState(() {
      isPostsTab = isPosts;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(0,screenHeight * 0.05,0,0),
        color: const Color(0xFF282828),
        child: Column(
          children: [
            const SizedBox(height: 8.0),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                      screenWidth * 0.1, 0, screenWidth * 0.02, screenHeight * 0.02),
                  width: screenWidth * 0.8,
                  child: Stack(
                    children: [
                      TextField(
                        onChanged: _onSearchChanged,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                          filled: true,
                          fillColor: const Color(0xFF1A1A1A),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SvgPicture.asset(
                              'assets/MagGlass.svg',
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _toggleTab(true),
                    child: Column(
                      children: [
                        Text(
                          'Posts',
                          style: TextStyle(
                            color: isPostsTab ? Colors.white : Colors.white54,
                            fontSize: 16.0,
                          ),
                        ),
                        if (isPostsTab)
                          Container(
                            height: 2.0,
                            color: Colors.white,
                          ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _toggleTab(false),
                    child: Column(
                      children: [
                        Text(
                          'Users',
                          style: TextStyle(
                            color: !isPostsTab ? Colors.white : Colors.white54,
                            fontSize: 16.0,
                          ),
                        ),
                        if (!isPostsTab)
                          Container(
                            height: 2.0,
                            color: Colors.white,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: isPostsTab
                  ? ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return
                    Container(
                      margin: EdgeInsets.fromLTRB(screenWidth * 0.01, screenHeight * 0.01, screenWidth * 0.01, 0),
                  width: screenWidth,
                  child: ProfilePublicPostedCard(
                    postName: posts[index]?.publisher?.username ?? "no name",
                    description: posts[index].description ?? "no description",
                    postDate: '',
                    imagePath: '',
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.6,
                  ),
                    );
                },
              )
                  : ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return
                    Container(
                      margin: EdgeInsets.fromLTRB(screenWidth * 0.01, screenHeight * 0.01, screenWidth * 0.01, 0),
                      width: screenWidth,
                      child:
                        UserCard(profile: users[index], screenWidth: screenWidth, screenHeight: screenHeight),
                    );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
