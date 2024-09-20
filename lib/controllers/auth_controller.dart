// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:talktune/models/user_model.dart';
import 'package:talktune/repositories/auth_repository.dart';

// Authentication controller provider
final authControllerProvider = Provider(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    return AuthController(
      authRepository: authRepository,
      ref: ref,
    );
  },
);

// User provider
final userProvider = FutureProvider(
  (ref) {
    final authController = ref.watch(authControllerProvider);
    return authController.getUser();
  },
);

// Authentication controller class
class AuthController {
  AuthController({
    required this.authRepository,
    required this.ref,
  });

  final AuthRepository authRepository;
  final ProviderRef ref;

  Future<UserModel?> getUser() async {
    UserModel? user = await authRepository.getUser();
    return user;
  }

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

  Stream<UserModel> getUserData(String userId) {
    return authRepository.getUserData(userId);
  }
}
