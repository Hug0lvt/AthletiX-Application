import 'package:flutter/material.dart';
import '../components/buttonProfilePage.dart';

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
                    borderRadius: BorderRadius.circular(25.0), // Coins arrondis du cadre
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Contenu de la nouvelle p3ge',
                        style: TextStyle(
                          color: Colors.black, // Couleur du texte à l'intérieur du cadre
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'coucou',
                                style: TextStyle(
                                  color: Colors.amber,
                                ),
                              ),
                              Text(
                                '1',
                                style: TextStyle(
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'coucou',
                                style: TextStyle(
                                  color: Colors.amber,
                                ),
                              ),
                              Text(
                                '2',
                                style: TextStyle(
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'coucou',
                                style: TextStyle(
                                  color: Colors.amber,
                                ),
                              ),
                              Text(
                                '3',
                                style: TextStyle(
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'coucou',
                                style: TextStyle(
                                  color: Colors.amber,
                                ),
                              ),
                              Text(
                                '4',
                                style: TextStyle(
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonProfilePage(text: 'coucou'),
                    ButtonProfilePage(text: 'coucou'),
                    ButtonProfilePage(text: 'coucou'),
                    ButtonProfilePage(text: 'coucou'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



