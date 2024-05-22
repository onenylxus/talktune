import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:talktune/constants/colors.dart';
import 'package:talktune/screens/home_screen.dart';
import 'package:talktune/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Talktune',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: colorBackground,
      ),
      home: const HomeScreen(),
    );
  }
}
