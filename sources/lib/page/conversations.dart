import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/conversation.dart';
import '../main.dart';
import '../utils/appColors.dart';
import 'package:AthletiX/providers/api/clientApi.dart';
import 'package:AthletiX/providers/api/utils/conversationClientApi.dart';
import 'package:AthletiX/model/conversation.dart';
import 'package:AthletiX/providers/localstorage/secure/authManager.dart';
import 'package:AthletiX/model/profile.dart';

class ConversationPage extends StatefulWidget {
  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  Profile? _profile;
  List<Conversation> conversations = [];
  bool _isLoading = true;
  final ConversationClientApi conversationsClientApi = getIt<ConversationClientApi>();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    Profile? profile = await AuthManager.getProfile();

    if (profile != null) {
      List<Conversation> fetchedConversations = await conversationsClientApi.getConversationsByUserId(profile.id!);
      setState(() {
        _profile = profile;
        conversations = fetchedConversations;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildImage(Conversation conv, double screenWidth, double screenHeight) {
    try {
      if (conv.picture!.isNotEmpty) {
        return Image.memory(
          base64Decode(conv.picture!),
          fit: BoxFit.cover,
          width: screenWidth * 0.20,
          height: screenWidth * 0.20,
        );
      } else {
        throw Exception("Image is empty");
      }
    } catch (e) {
      return Image.network("https://via.placeholder.com/${screenWidth * 0.20 }/3C383B/B66CFF?text=${conv.name?.substring(0,1)}",
        fit: BoxFit.cover,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyDark,
      appBar: AppBar(
        backgroundColor: AppColors.greyDark,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Mes tchats",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/EditIcon.svg',
                width: 30,
                height: 30,
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: _isLoading
            ? Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: AppColors.blackLight,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 100,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: conversations.isEmpty
                  ? Center(
                child: Text(
                  'No conversations available.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: conversations.length,
                itemBuilder: (context, index) {
                  return ConversationWidget(data: conversations[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
