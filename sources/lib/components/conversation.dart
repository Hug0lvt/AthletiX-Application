import 'package:flutter/material.dart';
import 'package:sources/utils/appColors.dart';


class ConversationWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  ConversationWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
      },
      subtitle: Row(
        children: [
          const CircleAvatar(
            radius: 35,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/testAvatar.jpg'),
          ),
          const SizedBox(width: 15),
          Column(
            children: [
              Text(data['username'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),),
              Text(
                data['lastMessage'],
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
              Text(data['timeAgo'], style: const TextStyle(
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
                        "${data['unreadMessages']}",
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