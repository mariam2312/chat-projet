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
    apiKey: 'AIzaSyCgXnqP1r34yBoV5sKH1y450assqaBf3PA',
    appId: '1:16989222211:web:9c4ae771f83cf06c65ebf6',
    messagingSenderId: '16989222211',
    projectId: 'chat-app-c5690',
    authDomain: 'chat-app-c5690.firebaseapp.com',
    storageBucket: 'chat-app-c5690.appspot.com',
    measurementId: 'G-ZZ4WFX63GW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAlA34MybxDvRDCJsfZXP8q9LsF6Tqw3ck',
    appId: '1:16989222211:android:cf85d89f559efb6e65ebf6',
    messagingSenderId: '16989222211',
    projectId: 'chat-app-c5690',
    storageBucket: 'chat-app-c5690.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDnAWDXC_uHLoWK4OMp9SCLqUNY2j6_zI8',
    appId: '1:16989222211:ios:204e30981d99362d65ebf6',
    messagingSenderId: '16989222211',
    projectId: 'chat-app-c5690',
    storageBucket: 'chat-app-c5690.appspot.com',
    iosBundleId: 'com.example.project13',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDnAWDXC_uHLoWK4OMp9SCLqUNY2j6_zI8',
    appId: '1:16989222211:ios:b3d34cab2dc86d3e65ebf6',
    messagingSenderId: '16989222211',
    projectId: 'chat-app-c5690',
    storageBucket: 'chat-app-c5690.appspot.com',
    iosBundleId: 'com.example.project13.RunnerTests',
  );
}
