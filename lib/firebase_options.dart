// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCW73yEX0Z-7hlsj34vf3xRAyVDDh9W92c',
    appId: '1:963805576197:web:49230bd90199956da4306c',
    messagingSenderId: '963805576197',
    projectId: 'sentinel-7079d',
    authDomain: 'sentinel-7079d.firebaseapp.com',
    storageBucket: 'sentinel-7079d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAP7jVda0hZxABqa5j5vbxKMyi0kSurnYI',
    appId: '1:963805576197:android:e124e437cef8b285a4306c',
    messagingSenderId: '963805576197',
    projectId: 'sentinel-7079d',
    storageBucket: 'sentinel-7079d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZDelULpIl0GBiT5FgS8CZn2e16huuYaQ',
    appId: '1:963805576197:ios:d0b41a89de626d58a4306c',
    messagingSenderId: '963805576197',
    projectId: 'sentinel-7079d',
    storageBucket: 'sentinel-7079d.appspot.com',
    iosClientId: '963805576197-01h6fkv43rcg0dhlsnn45vp5gutc97me.apps.googleusercontent.com',
    iosBundleId: 'com.example.sentinel',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBZDelULpIl0GBiT5FgS8CZn2e16huuYaQ',
    appId: '1:963805576197:ios:d0b41a89de626d58a4306c',
    messagingSenderId: '963805576197',
    projectId: 'sentinel-7079d',
    storageBucket: 'sentinel-7079d.appspot.com',
    iosClientId: '963805576197-01h6fkv43rcg0dhlsnn45vp5gutc97me.apps.googleusercontent.com',
    iosBundleId: 'com.example.sentinel',
  );
}
