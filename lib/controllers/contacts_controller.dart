import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talktune/repositories/contacts_repository.dart';

final contactsControllerProvider = Provider(
  (ref) {
    final contactsRepository = ref.watch(contactsRepositoryProvider);
    return ContactsController(
      contactsRepository: contactsRepository,
      ref: ref,
    );
  },
);

final contactsProvider = FutureProvider(
  (ref) {
    final contactsRepository = ref.watch(contactsRepositoryProvider);
    return contactsRepository.getContacts();
  },
);

class ContactsController {
  ContactsController({
    required this.contactsRepository,
    required this.ref,
  });

  final ContactsRepository contactsRepository;
  final ProviderRef ref;

  void selectContact(Contact contact, BuildContext context) {
    contactsRepository.selectContact(contact, context);
  }
}
