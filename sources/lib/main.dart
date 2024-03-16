import 'package:AthletiX/page/home.dart';
import 'package:AthletiX/page/login/createProfile.dart';
import 'package:AthletiX/page/login/login.dart';
import 'package:AthletiX/page/login/register.dart';
import 'package:AthletiX/page/login/start.dart';
import 'package:AthletiX/page/profilePrivate.dart';
import 'package:AthletiX/page/profilePublic.dart';
import 'package:AthletiX/providers/api/clientApi.dart';
import 'package:AthletiX/providers/api/utils/profileClientApi.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void setupLocator() {
  getIt.registerSingleton<ClientApi>(
      ClientApi(
          'https://codefirst.iut.uca.fr/containers/AthletiX-ath-api/api',
          'https://codefirst.iut.uca.fr/containers/AthletiX-ath-api'
      ));
  getIt.registerSingleton<ProfileClientApi>(
      ProfileClientApi(getIt<ClientApi>()));
}

Future<void> initApp() async{
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupLocator(); // DI (usage : final clientApi = getIt<ClientApi>(); ...)
}

Future<void> main() async {
  // For start application
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Athletix',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/start',
      routes: {
        '/start': (context) => StartPage(),
        '/register': (context) => const RegisterForm(),
        '/login': (context) => const LoginForm(),
        '/createProfile': (context) => const CreateProfileForm(),
        '/home': (context) => HomePage(),
        '/profile/public': (context) => ProfilePublicPage(),
        '/profile/private': (context) => ProfilePrivatePage(),
      },
    );
  }
}
