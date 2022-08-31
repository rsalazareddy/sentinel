import 'package:flutter/material.dart';
import 'package:sentinel/auth/user_info.dart';
import 'package:sentinel/chat/chat_screen.dart';
import 'package:sentinel/screens/error.dart';
import 'package:sentinel/screens/otp_screen.dart';
import 'package:sentinel/screens/select_contacts.dart';
import 'screens/log_in.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch(settings.name) {
    case LogIn.routeName:
      return MaterialPageRoute(
        builder: (context) => LogIn(),
      );
    case OTPScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => OTPScreen(
          verificationId: verificationId,
        ),
      );
    case UserInformationScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => UserInformationScreen(),
      );
    case SelectContactsScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => SelectContactsScreen(),
      );
    case MobileChatScreen.routeName:
    final arguments = settings.arguments as Map<String, dynamic>;
    final name = arguments['name'];
    final uid = arguments['uid'];
      return MaterialPageRoute(
        builder: (context) => MobileChatScreen(name: name, uid: uid),
      );
    default:
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
      body: ErrorScreen(),
    ));
  }
}