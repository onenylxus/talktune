// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:talktune/screens/chat_screen.dart';
import 'package:talktune/screens/login_screen.dart';
import 'package:talktune/screens/otp_screen.dart';
import 'package:talktune/screens/select_contacts_screen.dart';
import 'package:talktune/screens/user_info_screen.dart';
import 'package:talktune/widgets/error.dart';

// Generate route function
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ChatScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final uid = arguments['uid'];
      return MaterialPageRoute(
        builder: (context) => ChatScreen(
          name: name,
          uid: uid,
        ),
      );
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case OTPScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => OTPScreen(
          verificationId: verificationId,
        ),
      );
    case SelectContactsScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SelectContactsScreen(),
      );
    case UserInfoScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const UserInfoScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: WidgetError(error: 'This page does not exist'),
        ),
      );
  }
}
