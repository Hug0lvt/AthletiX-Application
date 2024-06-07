import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommentCard extends StatelessWidget {
  final String username;
  final String commentText;
  final String profileImageUrl;

  CommentCard({required this.username, required this.commentText, required this.profileImageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF202020),
              borderRadius: BorderRadius.circular(40.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      child: ClipOval(
                        child: Image.network(
                          profileImageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Text(
                      username,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Text(
                  commentText,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
