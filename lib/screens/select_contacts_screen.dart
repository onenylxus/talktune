import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talktune/controllers/contacts_controller.dart';
import 'package:talktune/widgets/error.dart';
import 'package:talktune/widgets/loader.dart';

class SelectContactsScreen extends ConsumerWidget {
  const SelectContactsScreen({super.key});

  static const routeName = '/select-contacts';

  void selectContact(WidgetRef ref, Contact contact, BuildContext context) {
    ref.read(contactsControllerProvider).selectContact(contact, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select Contacts'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            )
          ],
        ),
        body: ref.watch(contactsProvider).when(
              data: (contacts) => ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text(
                          contact.displayName,
                          style: const TextStyle(fontSize: 18),
                        ),
                        leading: contact.photo == null
                            ? null
                            : CircleAvatar(
                                backgroundImage: MemoryImage(contact.photo!),
                                radius: 30,
                              ),
                      ),
                    ),
                    onTap: () => selectContact(ref, contact, context),
                  );
                },
              ),
              error: (err, trace) => WidgetError(error: err.toString()),
              loading: () => const WidgetLoader(),
            ));
  }
}
