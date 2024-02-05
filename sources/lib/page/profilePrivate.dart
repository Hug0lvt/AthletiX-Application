import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sources/model/profile.dart';
import 'package:sources/providers/api/api_client.dart';
import 'package:sources/providers/api/profile_api_client.dart';
import '../components/buttonProfilePage.dart';
import '../components/editProfilContainer.dart';

class ProfilePrivateApiClient extends ApiClient with ProfileApiClient {
  ProfilePrivateApiClient(String baseUrl) : super(baseUrl);
}

class ProfilePrivatePage extends StatefulWidget {
  const ProfilePrivatePage({super.key});
  @override
  State<ProfilePrivatePage> createState() => _ProfilePrivatePage();
}


class _ProfilePrivatePage extends State<ProfilePrivatePage> {

  @override
  // TODO: implement baseUrl
  String get baseUrl => throw UnimplementedError();

  //final ProfilePrivateApiClient apiClient = ProfilePrivateApiClient("https://codefirst.iut.uca.fr/containers/AthletiX-ath-api/");
  final ProfilePrivateApiClient apiClient = ProfilePrivateApiClient("https://localhost:7028/api");
  late Future<Profile> FutureProfile = fetchData();

  @override
  void initState() {
    super.initState();
    //FutureProfile = apiClient.getProfileByEmail("zaky@gmail.com");
    //FutureProfile = apiClient.getProfileById(1);
    //fetchData();
  }

  Future<Profile> fetchData() async {
    try {
      // Utilisation de votre API client pour récupérer le profil par son ID
      final Profile profile = await apiClient.getProfileById(1);

      return profile;
    } catch (error) {
      // Gérer les erreurs ici
      print('Error fetching profile: $error');
      // Vous pouvez renvoyer une valeur par défaut ou une instance de Profile avec des valeurs par défaut ici
      throw Exception('Failed to fetch profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    void onPressed() {
      showModalBottomSheet<int>(
        showDragHandle: true,
        isScrollControlled: true,
        backgroundColor: Colors.black87,
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                Text(
                  'Edit my profile',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.1,
                    fontFamily: 'Mulish',
                  ),
                ),
                EditProfileContainer(onClose: () {
                  Navigator.pop(context);
                }),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xFF363636),
          padding: const EdgeInsets.all(36),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      margin: const  EdgeInsets.symmetric(vertical: 35.0),
                      constraints: BoxConstraints.expand(
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A).withOpacity(0.7),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child:
                      FutureBuilder<Profile>(
                        future: FutureProfile,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            // Affiche un indicateur de chargement pendant que les données sont récupérées
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            // Affiche une erreur si la récupération des données échoue
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData) {
                            // Affiche un message si les données ne sont pas disponibles
                            return Text('No data available');
                          } else {
                            print(snapshot.data!);
                            // Affiche les données de FutureProfile
                            Profile profile = snapshot.data!;
                            return


                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            profile.username,
                            style: TextStyle(
                              fontSize: ((screenWidth + screenHeight) / 2) * 0.040,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: screenWidth * 0.3,
                            height: 1.0,
                            color: const Color(0xFF434343),
                            margin: const EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Age',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.034,
                                    ),
                                  ),
                                  Text(
                                    profile.age.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.034,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Height',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.034,
                                    ),
                                  ),
                                  Text(
                                    profile.height.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.034,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Weight',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.034,
                                    ),
                                  ),
                                  Text(
                                    profile.weight.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.034,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      );

                          }},),

                    ),
                    Positioned(
                      top: 50.0,
                      right: 20.0,
                      child: IconButton(
                        onPressed: onPressed,
                        icon: SvgPicture.asset(
                          'assets/EditIcon.svg',
                          width: screenWidth * 0.034,
                          height: screenHeight * 0.034,
                        ),
                      ),
                    ),
                    // Image en haut au centre
                    Positioned(
                      top: 0,
                      child: ClipOval(
                        child: SvgPicture.asset(
                          'assets/EditIcon.svg',
                          width: screenWidth * 0.08,
                          height: screenHeight * 0.08,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonProfilePage(
                      text: 'Mon bouton',
                      imagePath: 'assets/PostIcon.svg',
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.07,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                    ),
                    ButtonProfilePage(
                      text: 'Mon bouton',
                      imagePath: 'assets/HeartIcon.svg',
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.07,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                    ),
                    ButtonProfilePage(
                      text: 'Mon bouton',
                      imagePath: 'assets/StatisticsIcon.svg',
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.07,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                    ),
                    ButtonProfilePage(
                      text: 'Mon bouton',
                      imagePath: 'assets/DoubleHaltereIcon.svg',
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.07,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                    ),
                    ButtonProfilePage(
                      text: 'Mon bouton',
                      imagePath: 'assets/SettingsIcon.svg',
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.07,
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                    ),
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



