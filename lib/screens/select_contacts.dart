import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentinel/contacts/controller.dart';
import 'package:sentinel/screens/error.dart';

import '../widgets/loader.dart';

class SelectContactsScreen extends ConsumerWidget {
  static const String routeName = '/select-contact';
  const SelectContactsScreen({Key? key}) : super(key: key);

  void selectContact(WidgetRef ref, Contact selectedContact, BuildContext context) {
    ref.read(selectContactControllerProvider).selectContact(selectedContact, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select contact'),
        ),
        body: ref.watch(getContactsProvider).when(
            data: (contactList) => ListView.builder(
                itemCount: contactList.length,
                itemBuilder: (context, index) {
                  final contact = contactList[index];
                  return InkWell(
                    onTap: () {
                      selectContact(ref, contact, context);
                    },
                    child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListTile(
                    title: Text(contact.displayName, style: TextStyle(fontWeight: FontWeight.w400),),
                    leading: contact.photo == null
                        ? null
                        : CircleAvatar(
                            backgroundImage: MemoryImage(contact.photo!),
                            radius: 30,
                          ),
                  ),
                  ),
                  );
                }),
            error: (err, trace) => ErrorScreen(),
            loading: () => const Loader()));
  }
}
