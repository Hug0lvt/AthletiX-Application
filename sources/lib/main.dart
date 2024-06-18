import 'dart:async';

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
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:signalr_core/signalr_core.dart';
import 'components/navBar/BottomNavigationBar.dart';
import 'model/profile.dart';

String firstPage = '/start';
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

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

void onStart(ServiceInstance serviceInstance) async{
  HubConnection? hubConnection;
  hubConnection = HubConnectionBuilder()
      .withUrl('https://codefirst.iut.uca.fr/containers/AthletiX-ath-api/chathub')
      .build();

  try {
    await hubConnection.start();
    print('SignalR connection started!');
  } catch (e) {
    print('Error while connecting to SignalR: $e');
  }


  /*Timer.periodic(Duration(seconds: 10), (timer) async {
    bool isServiceRunning = await FlutterBackgroundService().isRunning();
    if (!isServiceRunning) {
      timer.cancel();
      return;
    }

    // Listen to SignalR events
    try {
      // Example: Listen to a specific event 'newMessage'
      hubConnection?.on('newMessage', (arguments) {
        print('New message received in background: $arguments');
        // Handle the received message or trigger a notification
        // You can use flutter_local_notifications here to show a notification
      });
    } catch (e) {
      print('Error while listening to SignalR event: $e');
    }
  });*/
}

Future<void> main() async {
  await initApp();
  runApp(const MyApp());
}

Future<void> initApp() async{
  WidgetsFlutterBinding.ensureInitialized();
  initializeService();
  setupLocator();
  await _showNotification(title: "Atheltix - Nouveau Message", body:  "Yanns : Yo mec", payload: "");
  await isAuthanticated();
}

bool onBackground(ServiceInstance serviceInstance) {
  return true;
}
Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onBackground,
    ),
  );
  service.startService();
}

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings initializationSettingsIOS =
  DarwinInitializationSettings();
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
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

Future<void> _showNotification({
  required String title,
  required String body,
  String? payload,
}) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    'your_channel_id', // ID du canal
    'your_channel_name', // Nom du canal
    channelDescription: 'your_channel_description', // Description du canal
    importance: Importance.max,
    priority: Priority.high,
  );
  const DarwinNotificationDetails iOSPlatformChannelSpecifics =
  DarwinNotificationDetails();
  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );

  await flutterLocalNotificationsPlugin.show(
    0, // ID de la notification
    title, // Titre de la notification
    body, // Corps de la notification
    platformChannelSpecifics,
    payload: payload,
  );
}
