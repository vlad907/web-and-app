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
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBRQbv583ShiYdGAWFReu3yISPij8yACJo',
    appId: '1:554398845983:web:3d09a05d6515dd0a55d92a',
    messagingSenderId: '554398845983',
    projectId: 'assignment6-2ced2',
    authDomain: 'assignment6-2ced2.firebaseapp.com',
    storageBucket: 'assignment6-2ced2.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCpZJUA7GPqVG0j8tgmoLFreG2kJ57kakc',
    appId: '1:554398845983:android:5dc54509fb5bfece55d92a',
    messagingSenderId: '554398845983',
    projectId: 'assignment6-2ced2',
    storageBucket: 'assignment6-2ced2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAEyzrauYVku_Y6cmP47nY54TzeXImSq6I',
    appId: '1:554398845983:ios:b81384155731980d55d92a',
    messagingSenderId: '554398845983',
    projectId: 'assignment6-2ced2',
    storageBucket: 'assignment6-2ced2.appspot.com',
    iosBundleId: 'com.example.assignment7',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAEyzrauYVku_Y6cmP47nY54TzeXImSq6I',
    appId: '1:554398845983:ios:b81384155731980d55d92a',
    messagingSenderId: '554398845983',
    projectId: 'assignment6-2ced2',
    storageBucket: 'assignment6-2ced2.appspot.com',
    iosBundleId: 'com.example.assignment7',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBRQbv583ShiYdGAWFReu3yISPij8yACJo',
    appId: '1:554398845983:web:3de20387c444a47a55d92a',
    messagingSenderId: '554398845983',
    projectId: 'assignment6-2ced2',
    authDomain: 'assignment6-2ced2.firebaseapp.com',
    storageBucket: 'assignment6-2ced2.appspot.com',
  );
}