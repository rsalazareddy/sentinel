import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'log_in.dart';

class Landing extends StatelessWidget {
  const Landing({Key? key}) : super(key: key);

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LogIn.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 70),
        child: Column(
          children: [
            Center(child: Image.asset('assets/logo.png', scale: 30)),
            const SizedBox(height: 10),
            const Text('Your new way of\nmessagging', textAlign: TextAlign.center, style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28
              ),
            ),
            const SizedBox(height: 10),
            const Text('Make the most out of your conversations.', textAlign: TextAlign.center, style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 300,
              width: 400,
              child: Lottie.asset('assets/main.json'),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                navigateToLoginScreen(context);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 108, vertical: 12),
                elevation: 0,
                primary: const Color(0XFF0F75BC),
              ),
              child: const Text("Get started", style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.white
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text('By continuing to use Sentinel\nyou are accepting the', textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12
            ),
            ),
            GestureDetector(
              onTap: () {

              },
              child: const Text('Terms & Conditions', style: TextStyle(
                color: Color(0XFF0F75BC),
                fontSize: 12,
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}