import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorScreen extends StatelessWidget {
  static const routeName = '/error-screen';
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 70),
        child: Column(
          children: [
            Spacer(),
            Center(child: Text('Oops!', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),)),
            Center(child: Text('Something went wrong', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),)),
            SizedBox(height: 30),
            Text("It seems we were unable\nto process the request you made.", textAlign: TextAlign.center),
            SizedBox(
              width: 250,
              height: 250,
              child: Lottie.asset('assets/404error.json'),
            ),
            SizedBox(height: 20),
            Text("But don't worry! We're most likely\nworking on it.", textAlign: TextAlign.center),
            Spacer(),
          ],
        ),
      ),
    );
  }
}