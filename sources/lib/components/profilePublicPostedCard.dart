import 'package:flutter/material.dart';

class ProfilePublicPostedCard extends StatelessWidget {
  final String imagePath;
  final String postName;
  final String postDate;
  final String description;
  final double width;
  final double height;

  ProfilePublicPostedCard({
    required this.imagePath,
    required this.postName,
    required this.postDate,
    required this.description,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xe51a1a1a),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                postName,
                style: TextStyle(
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: height * 0.8,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              postDate,
              style: TextStyle(
                fontSize: width * 0.03,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: width * 0.03,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Text(
              "Read More",
              style: TextStyle(
                fontSize: width * 0.03,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
