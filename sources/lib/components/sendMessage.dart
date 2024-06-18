import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Importez le package flutter_svg

class SendMessage extends StatelessWidget {
  final double width;
  final double height;

  SendMessage({required this.width, required this.height});

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
          // Utilisez SvgPicture.asset pour charger l'icône SVG
          SvgPicture.asset(
            'assets/SendIcon.svg',
            width: 25.0,
            height: 25.0,
          ),
        ],
      ),
    );
  }
}
