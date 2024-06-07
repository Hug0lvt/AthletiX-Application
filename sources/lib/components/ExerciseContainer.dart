import 'package:AthletiX/model/exercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';

class ExerciseContainer extends StatelessWidget {
  final Exercise exercice;
  final Color? backgroundColor; // Nouveau paramètre pour la couleur de fond

  ExerciseContainer({
    required this.exercice,
    this.backgroundColor, // Paramètre optionnel
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dynamicSpacing = screenWidth * 0.02;
    final defaultBackgroundColor = const Color(0xE51A1A1A); // Couleur par défaut

    // Utilise la couleur fournie ou la couleur par défaut
    final backgroundColorToUse = backgroundColor ?? defaultBackgroundColor;

    final kGradientBoxDecoration = BoxDecoration(
      boxShadow: const [
        BoxShadow(
          color: Color(0x3F000000),
          blurRadius: 4,
          offset: Offset(0, 4),
          spreadRadius: 0,
        ),
      ],
      gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFB66CFF), Color(0xFFA2E4E6)]),
      borderRadius: BorderRadius.circular(10),
    );

    Widget _buildImage() {
      try {
        if (exercice.image.isNotEmpty) {
          return Image.memory(
            base64Decode(exercice.image),
            height: 50,
            width: 50,
          );
        } else {
          throw Exception("Image is empty");
        }
      } catch (e) {
        return SvgPicture.asset(
          "assets/default_exercice_image.svg",
          height: 50,
          width: 50,
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: kGradientBoxDecoration.copyWith(
            // Remplace la couleur par défaut par la couleur à utiliser
            color: backgroundColorToUse,
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              width: screenWidth * 0.97,
              decoration: ShapeDecoration(
                color: defaultBackgroundColor, // Utilise la couleur par défaut
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: _buildImage(),
                    ),
                    SizedBox(width: dynamicSpacing),
                    Text(
                      exercice.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.036,
                        fontFamily: 'Mulish',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
