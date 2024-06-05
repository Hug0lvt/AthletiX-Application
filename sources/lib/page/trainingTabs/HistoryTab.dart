import 'package:AthletiX/exceptions/not_found_exception.dart';
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

  late List<Session> sessions;

  bool isLoading = false;

  String searchQuery = '';

  @override
  void initState() {
    sessions = [];
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _loadSessions();
    });

  }
  void _loadSessions() async {
    setState(() {
      isLoading = true;
    });
    int? profileId;
    Profile? profile = await AuthManager.getProfile();
    if (profile != null) {
      profileId = profile.id;
    }
    try {
      List<Session> fetchedSessions = await clientApi.getPastSessionsOfUser(profileId);
      setState(() {
        sessions = fetchedSessions;
        isLoading = false;
      });
    } on NotFoundException catch (_) {
      // Gère spécifiquement la NotFoundException
      setState(() {
        sessions = []; // Aucune session trouvée
        isLoading = false;
      });
    }
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
                isLoading
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : sessions.isEmpty
                    ? const Center(
                  child: Text(
                    "No Past Sessions Found",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Mulish',
                    ),
                  ),
                )
                    : ListView.builder(
                  shrinkWrap: true,
                  itemCount: sessions.length,
                  itemBuilder: (context, index) {
                    return ProgramContainer(
                      title: sessions[index].name,
                      lastSession: DateTime.now()
                          .difference(sessions[index].date)
                          .inDays
                          .toString(), // in days
                      exercises: sessions[index].exercises,
                      onDelete: () => print("test"),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
