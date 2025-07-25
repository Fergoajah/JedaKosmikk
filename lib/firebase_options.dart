// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyA0c8EdtLjVxkZkm24aCnQhjavdr0HkvT0',
    appId: '1:898674837243:web:7dc1ec2a134359f3e5125e',
    messagingSenderId: '898674837243',
    projectId: 'jedakosmik',
    authDomain: 'jedakosmik.firebaseapp.com',
    storageBucket: 'jedakosmik.firebasestorage.app',
    measurementId: 'G-ZRY141NDHS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC2moKXQFvRSqbXUXh2vdBJ3z9BqTqOdCw',
    appId: '1:898674837243:android:3637ded52c98a642e5125e',
    messagingSenderId: '898674837243',
    projectId: 'jedakosmik',
    storageBucket: 'jedakosmik.firebasestorage.app',
  );
}
