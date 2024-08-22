import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talktune/constants/colors.dart';
import 'package:talktune/controllers/auth_controller.dart';
import 'package:talktune/router.dart';
import 'package:talktune/screens/home_screen.dart';
import 'package:talktune/screens/landing_screen.dart';
import 'package:talktune/firebase_options.dart';
import 'package:talktune/widgets/error.dart';
import 'package:talktune/widgets/loader.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'talktune',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: colorBackground,
        appBarTheme: const AppBarTheme(color: colorAppBar),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: ref.watch(userProvider).when(
            data: (user) {
              if (user == null) {
                return const LandingScreen();
              }
              return const HomeScreen();
            },
            error: (err, trace) {
              return WidgetError(error: err.toString());
            },
            loading: () => const WidgetLoader(),
          ),
    );
  }
}
