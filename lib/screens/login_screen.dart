// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:country_picker/country_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:talktune/constants/colors.dart';
import 'package:talktune/controllers/auth_controller.dart';
import 'package:talktune/utils/utils.dart';
import 'package:talktune/widgets/custom_button.dart';

// Login screen class
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/login-screen';

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

// Login screen state class
class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  Country? country;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void pickCountry() {
    showCountryPicker(
      context: context,
      onSelect: (Country country) {
        setState(() {
          this.country = country;
        });
      },
    );
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();

    if (country != null && phoneNumber.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .signIn(context, '+${country!.phoneCode}$phoneNumber');
    } else {
      showSnackBar(context: context, content: 'Please fill out all the fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Enter your phone number'),
        elevation: 0,
        backgroundColor: colorBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const Text('Talktune will need to verify your phone number.'),
            const SizedBox(height: 10),
            TextButton(
              onPressed: pickCountry,
              child: const Text('Pick country'),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                if (country != null) Text('+${country!.phoneCode}'),
                const SizedBox(width: 10),
                SizedBox(
                  width: size.width * 0.7,
                  child: TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      hintText: 'phone number',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.6),
            SizedBox(
              width: 90,
              child: CustomButton(
                onPressed: sendPhoneNumber,
                text: 'NEXT',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
