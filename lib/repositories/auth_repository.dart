// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:talktune/models/user_model.dart';
import 'package:talktune/repositories/firebase_repository.dart';
import 'package:talktune/screens/home_screen.dart';
import 'package:talktune/screens/otp_screen.dart';
import 'package:talktune/screens/user_info_screen.dart';
import 'package:talktune/utils/utils.dart';

// Authentication repository provider
final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

// Authentication repository class
class AuthRepository {
  AuthRepository({
    required this.auth,
    required this.firestore,
  });

  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  Future<UserModel?> getUser() async {
    String uid = auth.currentUser!.uid;
    var data = await firestore.collection('users').doc(uid).get();

    UserModel? user;
    if (data.data() != null) {
      user = UserModel.fromMap(data.data()!);
    }

    return user;
  }

  void signIn(BuildContext context, String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          throw Exception(e.message);
        },
        codeSent: (String verificationId, int? resendToken) async {
          Navigator.pushNamed(
            context,
            OTPScreen.routeName,
            arguments: verificationId,
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showSnackBar(context: context, content: e.message!);
      }
    }
  }

  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      await auth.signInWithCredential(credential);
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          UserInfoScreen.routeName,
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showSnackBar(context: context, content: e.message!);
      }
    }
  }

  void saveUser({
    required BuildContext context,
    required ProviderRef ref,
    required String name,
    required File? avatar,
  }) async {
    try {
      String uid = auth.currentUser!.uid;
      String url = '';

      if (avatar != null) {
        url = await ref
            .read(firebaseRepositoryProvider)
            .storeFile('avatars/$uid', avatar);
      }

      var user = UserModel(
        uid: uid,
        name: name,
        avatar: url,
        phoneNumber: auth.currentUser!.phoneNumber!,
        isOnline: true,
        groupId: [],
      );

      await firestore.collection('users').doc(uid).set(user.toMap());
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showSnackBar(context: context, content: e.message!);
      }
    }
  }

  Stream<UserModel> getUserData(String userId) {
    return firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((event) => UserModel.fromMap(event.data()!));
  }
}
