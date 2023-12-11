import 'package:flutter/material.dart';

class SendMessage extends StatelessWidget {
  final String text;
  final double width;
  final double height;

  SendMessage({required this.text, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      constraints: BoxConstraints.expand(
        width: width,
        height: height,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.black, width: 1.0),
        gradient: const LinearGradient(
          begin: Alignment(-0.5, 0.2),
          end: Alignment(0.2, -1.5),
          colors: [
            Color(0xE6BF7FFF),
            Color(0xE6A2E4E6),
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 4),
            blurRadius: 4.0,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          Image.asset(
            '../assets/sendIcon.png',
            width: 30.0,
            height: 30.0,
          ),
        ],
      ),
    );
  }
}
