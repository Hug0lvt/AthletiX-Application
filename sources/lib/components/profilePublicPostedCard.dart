import 'package:flutter/material.dart';
import 'dart:typed_data';

class ProfilePublicPostedCard extends StatefulWidget {
  final String thumbnailUrl;
  final String postName;
  final String description;
  final double width;
  final double height;

  ProfilePublicPostedCard({
    required this.thumbnailUrl,
    required this.postName,
    required this.description,
    required this.width,
    required this.height,
  });

  @override
  _ProfilePublicPostedCardState createState() => _ProfilePublicPostedCardState();
}

class _ProfilePublicPostedCardState extends State<ProfilePublicPostedCard> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
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
                widget.postName,
                style: TextStyle(
                  fontSize: widget.width * 0.05,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: widget.thumbnailUrl.isEmpty
                  ? Image.asset(
                'assets/dumbbell_button.png',
                width: double.infinity,
                height: widget.height * 0.8,
                fit: BoxFit.cover,
              )
                  : Image.network(
                widget.thumbnailUrl,
                width: double.infinity,
                height: widget.height * 0.8,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              widget.description,
              style: TextStyle(
                fontSize: widget.width * 0.05,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Text(
              "Read More",
              style: TextStyle(
                fontSize: widget.width * 0.03,
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