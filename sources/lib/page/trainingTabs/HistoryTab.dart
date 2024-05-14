import 'package:AthletiX/model/profile.dart';
import 'package:AthletiX/providers/localstorage/secure/authManager.dart';
import 'package:flutter/material.dart';
import 'package:AthletiX/components/ProgramContainer.dart';
import 'package:AthletiX/model/session.dart';

import 'package:AthletiX/providers/api/utils/trainingClientApi.dart';
import 'package:AthletiX/main.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});
  @override
  State<HistoryTab> createState() => _HistoryTab();
}

class _HistoryTab extends State<HistoryTab> {

  final clientApi = getIt<TrainingClientApi>();

  get onPressed => null;

  late Future<List<Session>> FutureSessions;

  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    int? profileId;
    Future<Profile?> profileFuture = AuthManager.getProfile();
    FutureBuilder<Profile?>(
      future: profileFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Profile? profile = snapshot.data!;
            profileId = profile.id;
          }
          return const CircularProgressIndicator();
        },
    );
    FutureSessions = clientApi.getSessionsOfUser(profileId);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        color: const Color(0xFF282828),
        child:
        Column(
          children: [
            const SizedBox(height: 8.0),
            Row(
              children: [
                const SizedBox(width: 8.0),
                const Text(
                  'Training History',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Mulish',),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    height: 1.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
          ListView(
            shrinkWrap: true,
            children: [
              FutureBuilder<List<Session>>(
                future: FutureSessions,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Session> allSessions = snapshot.data!;
                    for (int i = 0; i < allSessions.length; i++) {
                      ProgramContainer(
                        title: allSessions[i].name,
                        lastSession : DateTime.now().difference(allSessions[i].date).inDays.toString(), // in days
                        exercises : allSessions[i].exercises
                      );
                    }
                  }
                  return const Center(
                    child: Text(
                      "No Past Sessions Found",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Mulish',
                      ),
                    ),
                  ) ;
                },
              )
          ],
              /*ListView(
                shrinkWrap: true,
                children:*/

                /*[
                  ProgramContainer(
                    title: 'Push',
                    lastSession: '19',
                    exercises: [
                      '4 x 8 Dumbbell Benchpress',
                      '4 x 8 Inclined Dumbbell Benchpress',
                      '4 x 8 Machine Fly',
                      '4 x 8 Cable Triceps',
                    ],
                  ),
                  ProgramContainer(
                    title: 'Pull',
                    lastSession: '1',
                    exercises: [
                      '4 x 8 Pull-ups',
                      '4 x 8 Barbell Rows',
                      '4 x 8 Lat Pulldowns',
                      '4 x 8 Face Pulls',
                    ],
                  ),
                  // Add more ProgramContainer widgets as needed
                ],
              ),*/
            ),
          ],
        ),
      ),
    );
  }
}
