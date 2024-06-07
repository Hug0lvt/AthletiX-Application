import 'package:AthletiX/model/authentification/login/loginResponse.dart';
import 'package:AthletiX/model/authentification/login/refresh.dart';
import 'package:AthletiX/page/home.dart';
import 'package:AthletiX/page/login/createProfile.dart';
import 'package:AthletiX/page/login/login.dart';
import 'package:AthletiX/page/login/register.dart';
import 'package:AthletiX/page/login/start.dart';
import 'package:AthletiX/page/profilePrivate.dart';
import 'package:AthletiX/page/profilePublic.dart';
import 'package:AthletiX/providers/api/clientApi.dart';
import 'package:AthletiX/providers/api/utils/categoryClientApi.dart';
import 'package:AthletiX/providers/api/utils/commentClientApi.dart';
import 'package:AthletiX/providers/api/utils/conversationClientApi.dart';
import 'package:AthletiX/providers/api/utils/exerciseClientApi.dart';
import 'package:AthletiX/providers/api/utils/messageClientApi.dart';
import 'package:AthletiX/providers/api/utils/postClientApi.dart';
import 'package:AthletiX/providers/api/utils/practicalexerciseClientApi.dart';
import 'package:AthletiX/providers/api/utils/profileClientApi.dart';
import 'package:AthletiX/providers/api/utils/sessionClientApi.dart';
import 'package:AthletiX/providers/api/utils/setClientApi.dart';
import 'package:AthletiX/providers/api/utils/trainingClientApi.dart';
import 'package:AthletiX/providers/localstorage/secure/authKeys.dart';
import 'package:AthletiX/providers/localstorage/secure/authManager.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'components/navBar/BottomNavigationBar.dart';

import 'model/profile.dart';

String firstPage = '/start';
final getIt = GetIt.instance;
void setupLocator() {

  getIt.registerSingleton<ClientApi>(
      ClientApi(
          'https://codefirst.iut.uca.fr/containers/AthletiX-ath-api/api',
          'https://codefirst.iut.uca.fr/containers/AthletiX-ath-api'
      ));
  getIt.registerSingleton<ExerciseClientApi>(ExerciseClientApi(getIt<ClientApi>()));
  getIt.registerSingleton<ProfileClientApi>(ProfileClientApi(getIt<ClientApi>()));
  getIt.registerSingleton<CommentClientApi>(CommentClientApi(getIt<ClientApi>(), PostClientApi(getIt<ClientApi>())));
  getIt.registerSingleton<TrainingClientApi>(TrainingClientApi(getIt<ClientApi>()));
  getIt.registerSingleton<CategoryClientApi>(CategoryClientApi(getIt<ClientApi>()));
  getIt.registerSingleton<ConversationClientApi>(ConversationClientApi(getIt<ClientApi>()));
  getIt.registerSingleton<MessageClientApi>(MessageClientApi(getIt<ClientApi>()));
  getIt.registerSingleton<PostClientApi>(PostClientApi(getIt<ClientApi>()));
  getIt.registerSingleton<SessionClientApi>(SessionClientApi(getIt<ClientApi>()));
  getIt.registerSingleton<SetClientApi>(SetClientApi(getIt<ClientApi>()));
  getIt.registerSingleton<PracticalExerciseClientApi>(PracticalExerciseClientApi(getIt<ClientApi>()));
  }


Future<void> isAuthanticated() async {
  String? token = await AuthManager.getToken(AuthKeys.ATH_BEARER_TOKEN_API.name);
  print('Retrieved token: $token');
  String? refreshToken = await AuthManager.getToken(AuthKeys.ATH_BEARER_REFRESH_TOKEN_API.name);
  Profile? profile = await AuthManager.getProfile();
  DateTime? expireAt = DateTime.tryParse(await AuthManager.getToken(AuthKeys.ATH_END_OF_BEARER_TOKEN_API.name) ?? "");

  if(token != null && refreshToken != null && profile != null){
    //if(expireAt != null && expireAt.isBefore(DateTime.now())){
    if(expireAt != null ){
      try {
        LoginResponse loginResponse = await getIt<ClientApi>().authClientApi.refreshToken(Refresh(refreshToken: refreshToken));
        await AuthManager.setToken(AuthKeys.ATH_BEARER_TOKEN_API.name, loginResponse.accessToken);
        await AuthManager.setToken(AuthKeys.ATH_BEARER_REFRESH_TOKEN_API.name, loginResponse.refreshToken);
        await AuthManager.setToken(AuthKeys.ATH_END_OF_BEARER_TOKEN_API.name, DateTime.now().add(const Duration(seconds: 3500)).toString());
        firstPage = '/navbar';
      } catch (ignored) {}
    }else{
      firstPage = '/navbar';
    }
  } else {
    firstPage = '/start';
  }
}

Future<void> initApp() async{
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await isAuthanticated();
}

Future<void> main() async {
  // For start application
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
      initialRoute: firstPage,
      routes: {
        // Pour la phase de login et inscription
        '/start': (context) => StartPage(),
        '/register': (context) => const RegisterForm(),
        '/login': (context) => const LoginForm(),
        '/createProfile': (context) => const CreateProfileForm(),
        // NavBar
        '/navbar': (context) => const DefaultBottomNavigationBar(),
        // Navigation
        '/home': (context) => HomePage(),
        '/profile/public': (context) => ProfilePublicPage(),
        '/profile/private': (context) => ProfilePrivatePage(),
      },
    );
  }
}
