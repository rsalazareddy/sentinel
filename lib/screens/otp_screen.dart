import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentinel/auth/auth_controller.dart';

class OTPScreen extends ConsumerWidget {
  static const String routeName = '/otp-screen';
  final String verificationId;
  const OTPScreen({Key? key, required this.verificationId}) : super(key: key);

  void verifyOTP(WidgetRef ref, BuildContext context, String userOTP) {
    ref.read(authControllerProvider).verifyOTP(
      context, 
      verificationId, 
      userOTP
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 170),
        child: Column(
          children: [
            SizedBox(height: 90),
            Center(
              child: Text('Enter your OTP', style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),),
            ),
            SizedBox(height: 10),
            Center(
              child: Text("We've sent a 6-digit code\nto your phone number", textAlign: TextAlign.center),
            ),
            SizedBox(height: 60),
            Expanded(
              child: TextField(
                onChanged: (val) {
                  if(val.length == 6) {
                    verifyOTP(ref, context, val.trim());
                  }
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(6),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter your code'
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}