import 'package:AthletiX/page/addTraining.dart';
import 'package:AthletiX/model/profile.dart';
import 'package:AthletiX/providers/localstorage/secure/authManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:AthletiX/providers/api/utils/trainingClientApi.dart';
import 'package:AthletiX/components/ProgramContainer.dart';
import 'package:AthletiX/model/session.dart';
import 'package:AthletiX/main.dart';

import '../../exceptions/not_found_exception.dart';


class TrainingTab extends StatefulWidget {
  const TrainingTab({super.key});
  @override
  State<TrainingTab> createState() => _TrainingTab();
}

class _TrainingTab extends State<TrainingTab> {

  final clientApi = getIt<TrainingClientApi>();

  get onPressed => null;

  late List<Session> sessions;

  bool isLoading = false;

  late List<Session> filteredSessions;
  String searchQuery = '';

  @override
  void initState() {
    sessions = [];
    filteredSessions = [];
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
      List<Session> fetchedSessions = await clientApi.getProgramsOfUser(profileId);
      List<Session> filterSessions = fetchedSessions
          .where((session) =>
          session.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
      setState(() {
        filterSessions = filteredSessions;
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
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Color(0xFF282828),
        child: Column(
          children: [
            const SizedBox(height: 8.0),
            SizedBox(
              width: screenWidth * 0.9,
              child: Stack(
                children: [
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                      ),
                      filled: true,
                      fillColor: const Color(0xFF1A1A1A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SvgPicture.asset(
                          'assets/MagGlass.svg',
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const SizedBox(width: 8.0),
                const Text(
                  'My Training Programs',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Mulish',
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    height: 1.0,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddTrainingPage()),
                    );
                  },
                  icon: SvgPicture.asset('assets/AddPlus.svg'),)
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
                    : filteredSessions.isEmpty
                    ? const Center(
                  child: Text(
                    "No Programs Found",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Mulish',
                    ),
                  ),
                )
                    : ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredSessions.length,
                  itemBuilder: (context, index) {
                    return ProgramContainer(
                      title: filteredSessions[index].name,
                      lastSession: '',
                      exercises: filteredSessions[index].exercises,
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
