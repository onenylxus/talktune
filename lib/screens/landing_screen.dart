// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:talktune/constants/colors.dart';
import 'package:talktune/screens/login_screen.dart';
import 'package:talktune/widgets/custom_button.dart';

// Landing screen class
class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  void navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Text(
              'Welcome to Talktune',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 33,
              ),
            ),
            SizedBox(height: size.height / 9),
            Image.asset(
              'assets/landing.png',
              width: 340,
              height: 340,
              color: colorTab,
            ),
            SizedBox(height: size.height / 9),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Read our Privacy Policy. Tap "Agree and Continue" to accept the Terms of Service.',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: size.width * 0.75,
              child: CustomButton(
                text: 'AGREE AND CONTINUE',
                onPressed: () => navigateToLogin(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
