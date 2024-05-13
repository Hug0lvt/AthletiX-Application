import 'package:flutter/material.dart';
import 'package:sources/providers/api/api_client.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/ProgramContainer.dart';
import '../../model/session.dart';
import '../../providers/api/session_api_client.dart';

class TrainingApiClient extends ApiClient with SessionApiClient {
  TrainingApiClient(String baseUrl) : super(baseUrl);
}

class TrainingTab extends StatefulWidget {
  const TrainingTab({super.key});
  @override
  State<TrainingTab> createState() => _TrainingTab();
}

class _TrainingTab extends State<TrainingTab> {
  get onPressed => null;

  final TrainingApiClient apiClient =
  TrainingApiClient("https://codefirst.iut.uca.fr/containers/AthletiX-ath-api/api");
  late Future<List<Session>> FutureSessions;

  String searchQuery = ''; // Add this line to store the search query

  @override
  void initState() {
    super.initState();
    FutureSessions = apiClient.getAllSessions();
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
                  onPressed: onPressed,
                  icon: SvgPicture.asset('assets/AddPlus.svg'),
                )
              ],
            ),
            const SizedBox(height: 8.0),
            FutureBuilder<List<Session>>(
              future: FutureSessions,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print("HAS DATA");
                  List<Session> allSessions = snapshot.data!;
                  List<Session> filteredSessions = allSessions
                      .where((session) =>
                      session.name.toLowerCase().contains(searchQuery.toLowerCase()))
                      .toList();

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredSessions.length,
                    itemBuilder: (context, index) {
                      return ProgramContainer(
                        title: filteredSessions[index].name,
                        lastSession: '',
                        exercises: filteredSessions[index].exercises,
                      );
                    },
                  );
                }
                return Text(
                  "No Sessions Found"
                  ,style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Mulish',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
