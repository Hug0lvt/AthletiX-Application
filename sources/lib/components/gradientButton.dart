import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final Widget icon;
  final double width;
  final double height;
  final VoidCallback? onPressed;
  final Color? disabledColor;

  GradientButton({
    required this.icon,
    required this.width,
    required this.height,
    required this.onPressed,
    this.disabledColor
  });

  @override
  Widget build(BuildContext context) {
    bool isDisabled = onPressed == null;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: isDisabled
              ? null
              : LinearGradient(
            colors: [
              Color(0xE6BF7FFF),
              Color(0xE6A2E4E6),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          color: isDisabled ? (disabledColor ?? Colors.grey) : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}