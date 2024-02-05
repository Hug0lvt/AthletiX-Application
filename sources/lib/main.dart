import 'package:flutter/material.dart';
import 'package:sources/page/home.dart';
import 'package:sources/page/TrainingHome.dart';
import 'package:sources/page/profilePublic.dart';
import 'page/profilePrivate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TrainingHome(),
    );
  }
}
