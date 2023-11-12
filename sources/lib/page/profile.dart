import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xFF363636), // Couleur #363636 en format hexadécimal
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  constraints: const BoxConstraints.expand(width: 320, height: 150),
                  decoration: BoxDecoration(
                    color: Colors.white, // Couleur du cadre
                    borderRadius: BorderRadius.circular(10.0), // Coins arrondis du cadre
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Contenu de la nouvelle page',
                        style: TextStyle(
                          color: Colors.black, // Couleur du texte à l'intérieur du cadre
                        ),
                      ),
                      Text(
                        'coucou',
                        style: TextStyle(
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // Ajoutez d'autres widgets ici pour le contenu en dessous
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

