import 'package:flutter/material.dart';

class AppColors {
  static final AppColors _instance = AppColors._internal();

  factory AppColors() {
    return _instance;
  }

  AppColors._internal();

  static const Color greyDark = Color(0xFF282828);
  static const Color black = Color(0xFF232323);
  static const Color grey = Color(0xFF323232);
  static const Color blackLight = Color(0xE51A1A1A);
  static const Color textGrey = Color(0xFFBABABA);
  static const Color greyLight = Color(0x80FFFFFF);
  static const Color greyMid = Color(0xF23C3C3C);
  static const Color greyMidDark = Color(0x1A1A1A75);
  static const Color textBlueLight = Color(0xFFA2E4E6);
  static const Color violet = Color(0xFFB66CFF);
}