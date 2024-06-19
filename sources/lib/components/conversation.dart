import 'dart:convert';

import 'package:flutter/material.dart';
import '../utils/appColors.dart';
import 'package:AthletiX/model/conversation.dart';

class ConversationWidget extends StatelessWidget {
  final Conversation data;

  ConversationWidget({required this.data});

  Widget _buildImage(double screenWidth, double screenHeight) {
    try {
      if (data.picture!.isNotEmpty) {
        return Image.memory(
          base64Decode(data.picture!),
          fit: BoxFit.cover,
          width: screenWidth * 0.20,
          height: screenWidth * 0.20,
        );
      } else {
        throw Exception("Image is empty");
      }
    } catch (e) {
      return Image.network("https://via.placeholder.com/${screenWidth * 0.20 }/3C383B/B66CFF?text=${data.name?.substring(0,1)}",
        fit: BoxFit.cover,);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return ListTile(
      onTap: () {
      },
      subtitle: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.white,
            child: ClipOval(child : _buildImage(screenWidth, screenHeight))
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.name ?? 'No Name',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Text(
                data.messages?.isNotEmpty == true ? data.messages!.last.content : 'No Messages',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textGrey,
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                'Time Ago', // Remplacez ceci par le formatage de l'heure approprié si nécessaire
                style: const TextStyle(
                  color: AppColors.textBlueLight,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFA2E4E6),
                      Color(0xFFCACFEA),
                      Color(0xFFB66CFF),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Center(
                  child: Text(
                    "${/*data.messages?.where((msg) => msg.isUnread).length ??*/ 0}", // Remplacez par le calcul correct des messages non lus
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
