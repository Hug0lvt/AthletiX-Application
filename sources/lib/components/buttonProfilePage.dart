import 'package:flutter/material.dart';

class ButtonProfilePage extends StatelessWidget {
  final String text;

  ButtonProfilePage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xFF1A1A1A).withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            color: Color(0xF3B9EE).withOpacity(0.2),
            offset: Offset(3, 3),
            blurRadius: 2.0,
            spreadRadius: 0,
            blurStyle: BlurStyle.normal,
          ),
          BoxShadow(
            color: Color(0xA2E4E6).withOpacity(0.2),
            offset: Offset(-3, -3),
            blurRadius: 2.0,
            spreadRadius: 0,
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
      padding: EdgeInsets.all(16.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
