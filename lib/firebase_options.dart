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
    apiKey: 'AIzaSyCqpwOP5QOmtue9eI72naWtqLGA3y4v75k',
    appId: '1:339682290746:web:48a721043536c6bcec9903',
    messagingSenderId: '339682290746',
    projectId: 'photogram-700ab',
    authDomain: 'photogram-700ab.firebaseapp.com',
    storageBucket: 'photogram-700ab.appspot.com',
    measurementId: 'G-6ZF2BBL2GQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBRMOr5gLgSR9_xc2sAXY3ZYzR_lvNv59o',
    appId: '1:339682290746:android:a4db6a2d09154be5ec9903',
    messagingSenderId: '339682290746',
    projectId: 'photogram-700ab',
    storageBucket: 'photogram-700ab.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCycVKPAQ-vv0CLUyPvH1QActP-kmWGLP0',
    appId: '1:339682290746:ios:6c249c8d911218f2ec9903',
    messagingSenderId: '339682290746',
    projectId: 'photogram-700ab',
    storageBucket: 'photogram-700ab.appspot.com',
    iosBundleId: 'com.example.photoGram',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCycVKPAQ-vv0CLUyPvH1QActP-kmWGLP0',
    appId: '1:339682290746:ios:6c249c8d911218f2ec9903',
    messagingSenderId: '339682290746',
    projectId: 'photogram-700ab',
    storageBucket: 'photogram-700ab.appspot.com',
    iosBundleId: 'com.example.photoGram',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCqpwOP5QOmtue9eI72naWtqLGA3y4v75k',
    appId: '1:339682290746:web:5be9c7fd618ab1d7ec9903',
    messagingSenderId: '339682290746',
    projectId: 'photogram-700ab',
    authDomain: 'photogram-700ab.firebaseapp.com',
    storageBucket: 'photogram-700ab.appspot.com',
    measurementId: 'G-PJT1HMWKPX',
  );
}
