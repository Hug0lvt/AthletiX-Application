import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:AthletiX/components/sendMessage.dart';
import 'package:AthletiX/model/profile.dart';

class UserCard extends StatelessWidget {
  final Profile profile;
  final double screenWidth;
  final double screenHeight;

  UserCard({
    required this.profile,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      constraints: BoxConstraints.expand(
        width: screenWidth * 0.9,
        height: screenHeight * 0.13,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipOval(
                child: _buildImage(),
              ),
              SizedBox(width: 10),
              Text(
                _trimUsername(profile.username),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
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
    );
  }

  Widget _buildImage() {
    try {
      if (profile.picture!.isNotEmpty) {
        return Image.memory(
          base64Decode(profile.picture!),
          fit: BoxFit.cover,
          width: screenHeight * 0.1,
          height: screenHeight * 0.1,
        );
      } else {
        throw Exception("Image is empty");
      }
    } catch (e) {
      return Image.network(
        "https://via.placeholder.com/80/3C383B/B66CFF?text=${profile.username?.substring(0, 1)}",
        fit: BoxFit.cover,
        width: screenHeight * 0.1,
        height: screenHeight * 0.1,
      );
    }
  }

  String _trimUsername(String? username) {
    if (username == null) return "No username";
    return username.length > 11 ? username.substring(0, 11) : username;
  }
}
