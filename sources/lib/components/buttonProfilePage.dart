import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonProfilePage extends StatelessWidget {
  final String text;
  final String imagePath;
  final double width;
  final double height;

  ButtonProfilePage({required this.text, required this.imagePath, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      constraints: BoxConstraints.expand(
        width: width,
        height: height,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(0.0),
          topRight: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(0.0),
        ),
        color: const Color(0xFF1A1A1A).withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            color: const Color(0xF3B9EE).withOpacity(0.2),
            offset: const Offset(3, 3),
            blurRadius: 2.0,
            spreadRadius: 0,
            blurStyle: BlurStyle.normal,
          ),
          BoxShadow(
            color: const Color(0xA2E4E6).withOpacity(0.2),
            offset: const Offset(-3, -3),
            blurRadius: 2.0,
            spreadRadius: 0,
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          SvgPicture.asset(
              imagePath,
              width: 50,
          ),
          const SizedBox(width: 20.0),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
