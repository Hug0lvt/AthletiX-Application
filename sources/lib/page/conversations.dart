import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/conversation.dart';
import '../utils/appColors.dart';

class ConversationPage extends StatefulWidget {
  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {

  final List<Map<String, dynamic>> conversations = [
    {
      'username': 'Utilisateur 1',
      'lastMessage': 'Bonjour !',
      'timeAgo': '4h',
      'unreadMessages': 2,
      'imageUrl': 'url_image_utilisateur_1',
    },
    {
      'username': 'Utilisateur 1',
      'lastMessage': 'Bonjour !',
      'timeAgo': '1h',
      'unreadMessages': 2,
      'imageUrl': 'url_image_utilisateur_1',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyDark,
      appBar: AppBar(
        backgroundColor: AppColors.greyDark,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Mes tchats",
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
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn) ,
              ),
              onPressed: () {
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: AppColors.blackLight,
                borderRadius: BorderRadius.circular(10)
              ),

              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/testAvatar.jpg'),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
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