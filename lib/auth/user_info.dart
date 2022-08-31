import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sentinel/auth/auth_controller.dart';
import 'package:sentinel/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInformationScreen extends ConsumerStatefulWidget {
  static const String routeName = '/user-information';
  UserInformationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserInformationScreen> createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  File? image;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {
      
    });
  }

  void storeUserData() async {
    String name = nameController.text.trim();

    if(name.isNotEmpty) {
      ref.read(authControllerProvider).saveUserDataToFirebase(context, name, image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
      child: Center(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 50),
        child: Column(
          children: [
            Text(
              "Customize your\nprofile",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26, 
                fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 60),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                image == null ? const CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/flagged/photo-1574874897534-036671407eda?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=761&q=80'),
                ): CircleAvatar(
                  radius: 100,
                  backgroundImage: FileImage(image!),
                ),
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.3),
                    backgroundBlendMode: BlendMode.darken,
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    selectImage();
                  },
                  child: Icon(Icons.add_a_photo),
                  backgroundColor: Color(0XFF0F75BC),
                ),
              ],
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Enter your name", style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),),
            ),
            Expanded(
              child: TextField(
                controller: nameController,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                storeUserData();
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 90, vertical: 12),
                elevation: 0,
                primary: const Color(0XFF0F75BC),
              ),
              child: const Text("Continue", style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.white),
              ),
            ),
          ],
        ),
      )
    ),
  ));
  }
}