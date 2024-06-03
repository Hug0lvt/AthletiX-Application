import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final Widget icon;
  final double width;
  final double height;
  final VoidCallback onPressed;

  GradientButton({
    required this.icon,
    required this.width,
    required this.height,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xE6BF7FFF),
              Color(0xE6A2E4E6),
            ], // Adjust colors as needed
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(8), // Adjust border radius as needed
        ),
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}