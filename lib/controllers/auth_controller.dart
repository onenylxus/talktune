import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talktune/repositories/auth_repository.dart';

final authControllerProvider = Provider(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);

    return AuthController(
      authRepository: authRepository,
      ref: ref,
    );
  },
);

class AuthController {
  AuthController({
    required this.authRepository,
    required this.ref,
  });

  final AuthRepository authRepository;
  final ProviderRef ref;

  void signIn(BuildContext context, String phoneNumber) {
    authRepository.signIn(context, phoneNumber);
  }

  void verifyOTP(BuildContext context, String verificationId, String userOTP) {
    authRepository.verifyOTP(
      context: context,
      verificationId: verificationId,
      userOTP: userOTP,
    );
  }

  void saveUser(BuildContext context, String name, File? avatar) {
    authRepository.saveUser(
      context: context,
      ref: ref,
      name: name,
      avatar: avatar,
    );
  }
}
