import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sources/utils/appColors.dart';

import '../components/bubbleMessage.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<Map<String, String>> messages = [
    {'sender': 'expediteur', 'text': 'Bonjour !'},
    {'sender': 'Utilisateur', 'text': 'Salut !'},
    {'sender': 'expediteur', 'text': 'BonjourBonjourBonjourBonjourBonjourBonjourBonjourBonjourBonjourBonjourBonjourBonjourBonjourBonjour !'},
    {'sender': 'Utilisateur', 'text': 'Salut !'},
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.greyDark,
        body:
        SafeArea(
          child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/back.svg',
                    width: 35,
                    height: 35,
                    colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn) ,
                  ),
                  onPressed: () {
                  },
                ),
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 15),
                      SizedBox(
                        width: 70,
                        height: 70,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage('assets/testAvatar.jpg'),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Nom du Destinataire',
                        style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Center(
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: Container(
                  height: 1,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final sender = messages[index]['sender']!;
                        final message = messages[index]['text']!;

                        if (sender == 'expediteur') {
                          return MessageBubbleSender(sender: sender, message: message);
                        } else {
                          return MessageBubbleReceiver(sender: sender, message: message);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),


            // Élément en bas (champ de saisie)
            Container(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 25),
              child: TextField(
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: 'Type message...',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  hintStyle: const TextStyle(
                    fontSize: 18,
                    color: AppColors.greyLight,
                    fontWeight: FontWeight.w300,
                  ),
                  suffixIcon: IconButton(
                    icon: SvgPicture.asset(
                      'assets/send.svg',
                      width: 30,
                      height: 30,
                    ),
                    onPressed: () {
                    },
                  ),
                  filled: true,
                  fillColor: AppColors.grey,
                ),
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}