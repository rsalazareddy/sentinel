import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:sentinel/auth/auth_controller.dart';
import 'package:sentinel/utils/utils.dart';

class LogIn extends ConsumerStatefulWidget{
  static const routeName = '/login-screen';
  LogIn({Key? key}) : super(key: key);

  @override
  ConsumerState<LogIn> createState() => _LogInState();
}

class _LogInState extends ConsumerState<LogIn> {

  final phoneController = TextEditingController();
  Country? country;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void pickCountry() {
    showCountryPicker(
      showPhoneCode: true,
      context: context, 
      onSelect: (Country _country) {
        setState(() {
          country = _country;
        });
    });
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    if(country!=null && phoneNumber.isNotEmpty) {
      ref
      .read(authControllerProvider)
      .signInWithPhone(context, '+${country!.phoneCode}$phoneNumber');
    } else {
      showSnackBar(context: context, content: 'Fill out the required fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 60),
        child: Column(
          children: [
            SizedBox(height: 30),
            Center(child: const Text("Let's get you verified!", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28
                ),
              )
            ),
            SizedBox(height: 15),
            Center(child: const Text("Sentinel will send a One-Time Password to your\nphone number to verify your device. Enter your\ncountry code followed by your phone number below.", textAlign: TextAlign.center, style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12
                ),
              )
            ),
            SizedBox(height: 15),
            InkWell(
              onTap: () {
                pickCountry();
              },
              child: Text('Choose your country', style: TextStyle(
                fontSize: 15,
                color: Color(0XFF0F75BC)
              ),),
            ),
            SizedBox(
              height: 250,
              width: 250,
              child: Lottie.asset('assets/verification.json'),
            ),
            SizedBox(height: 10),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text('Enter your phone number', style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400
                ),
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                if(country!=null)
                  Text('+${country!.phoneCode}   '),
                Expanded(
                  child: TextField(
                    controller: phoneController,
                    autofocus: false,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0XFFEFEFEF),
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none
                    ),
                  )
                )
              ],
            ),
            SizedBox(height: 28),
            ElevatedButton(
              onPressed: () {
                sendPhoneNumber();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 108, vertical: 12),
                elevation: 0,
                primary: const Color(0XFF0F75BC),
              ),
              child: const Text("Send OTP", style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.white
                ),
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Sentinel requires you to be at least ', style: TextStyle(fontSize: 12),),
                Text('16 years old', style: TextStyle(color: Color(0XFF0F75BC), fontSize: 12),)
              ],
            ),
            ),
            Text('to register an account and use our service', style: TextStyle(fontSize: 12),),
          ],
        ),
      ),
    );
  }
}