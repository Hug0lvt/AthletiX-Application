import 'package:AthletiX/model/session.dart';
import 'package:AthletiX/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../model/profile.dart';
import '../providers/localstorage/secure/authKeys.dart';
import '../providers/localstorage/secure/authManager.dart';

class ModifTrainingPage extends StatefulWidget {
  final Session session;

  ModifTrainingPage({required this.session});

  @override
  _ModifTrainingPageState createState() => _ModifTrainingPageState();
}

class _ModifTrainingPageState extends State<ModifTrainingPage> {
  late Session currentSession;

  @override
  void initState() {
    super.initState();
    currentSession = widget.session;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.black,
        backgroundColor: const Color(0xFF1B1B1B),
        title: SvgPicture.asset('assets/AthletiX.svg'),
        titleSpacing: -40,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20),
          child: SizedBox(),
        ),
      ),
      body: Container(
        color: const Color(0xFF282828),
        /*child: Column(
          children: [
            Text(
              'Session: ${currentSession.name}',
              style: const TextStyle(
                color: Colors.white
              ),
            ),
          ],
        ),*/
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 5, bottom: 10),
              child: Text(
                currentSession.name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Text aligné à droite
                        const Text(
                          'Text à droite',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                          ),
                        ),
                        const SizedBox(width: 10), // Espacement entre le texte et la ligne
                        Expanded(
                          child: Container(
                            height: 2, // Épaisseur de la ligne
                            color: Colors.white, // Couleur de la ligne
                            margin: const EdgeInsets.only(right: 2), // Marge à droite pour le padding
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 3,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Add set functionality here
                    },
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}