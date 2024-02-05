import 'package:flutter/material.dart';
import 'package:sources/providers/api/api_client.dart';

import '../../components/ProgramContainer.dart';
import '../../model/session.dart';
import '../../providers/api/session_api_client.dart';

class HistoryApiClient extends ApiClient with SessionApiClient {
  HistoryApiClient(String baseUrl) : super(baseUrl);
}

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});
  @override
  State<HistoryTab> createState() => _HistoryTab();
}

class _HistoryTab extends State<HistoryTab> {
  final HistoryApiClient apiClient = HistoryApiClient("https://codefirst.iut.uca.fr/containers/AthletiX-ath-api/");
  late Future<List<Session>> FutureSessions;

  @override
  void initState() {
    super.initState();
    FutureSessions = apiClient.getAllSessions();
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
                  return const CircularProgressIndicator();
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
