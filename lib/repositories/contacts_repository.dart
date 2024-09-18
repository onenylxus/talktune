import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talktune/models/user_model.dart';
import 'package:talktune/screens/chat_screen.dart';
import 'package:talktune/utils/utils.dart';

final contactsRepositoryProvider = Provider(
  (ref) => ContactsRepository(
    firestore: FirebaseFirestore.instance,
  ),
);

class ContactsRepository {
  ContactsRepository({
    required this.firestore,
  });

  final FirebaseFirestore firestore;

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];

    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return contacts;
  }

  void selectContact(Contact contact, BuildContext context) async {
    try {
      var users = await firestore.collection('users').get();

      bool isMatch = false;
      for (var doc in users.docs) {
        var data = UserModel.fromMap(doc.data());
        String phone = contact.phones[0].number.replaceAll(' ', '');

        if (phone == data.phoneNumber) {
          isMatch = true;
          if (context.mounted) {
            Navigator.pushNamed(
              context,
              ChatScreen.routeName,
              arguments: {
                'name': data.name,
                'uid': data.uid,
              },
            );
          }
        }
      }

      if (context.mounted && !isMatch) {
        showSnackBar(
          context: context,
          content: 'This number is not registered',
        );
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context: context, content: e.toString());
      }
    }
  }
}
