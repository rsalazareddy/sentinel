import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentinel/app_screens/mobile_layout_screen.dart';
import 'package:sentinel/auth/auth_controller.dart';
import 'package:sentinel/screens/error.dart';
import 'package:sentinel/screens/landing.dart';
import 'package:sentinel/widgets/loader.dart';
import 'router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark
    )
  );
  runApp(
    const ProviderScope(
      child: MyApp()
    )
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: ref.watch(userDataAuthProvider).when(
        data: (user) {
          if(user == null) {
            return const Landing();
          }
          return const MobileLayoutScreen();
        }, 
        error: (err, trace) {
          return ErrorScreen();
        }, 
        loading: () => const Loader(),
        ));
  }
}