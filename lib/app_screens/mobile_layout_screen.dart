import 'package:flutter/material.dart';
import 'package:sentinel/contacts/list.dart';
import 'package:sentinel/screens/select_contacts.dart';

class MobileLayoutScreen extends StatelessWidget {
  const MobileLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(child: Image.asset('assets/logo.png', scale: 37)),
        toolbarHeight: 60,
        bottom: PreferredSize(
          preferredSize:  Size.fromHeight(2),
          child: Text('')
        ),),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, SelectContactsScreen.routeName);
        },
        child: Icon(Icons.message),
      ),
      body: ContactsList()
    );
  }
}