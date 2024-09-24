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
    apiKey: 'AIzaSyC5Euh0rhTJ4xXuAeaYxXpOhkK0LG-oFv8',
    appId: '1:940732082733:web:6c4e71a5a6cb697e1de6a4',
    messagingSenderId: '940732082733',
    projectId: 'round1b',
    authDomain: 'round1b.firebaseapp.com',
    storageBucket: 'round1b.appspot.com',
    measurementId: 'G-MSWL485XQZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDJl1ogM5PPaHq4ZNhei0NA115UVShgNTU',
    appId: '1:940732082733:android:6e52bbdcba290cd51de6a4',
    messagingSenderId: '940732082733',
    projectId: 'round1b',
    storageBucket: 'round1b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAJPzTS9aGQCqqQdWQbnPPXJJOibANVzm4',
    appId: '1:940732082733:ios:8cc12ed61ea607e21de6a4',
    messagingSenderId: '940732082733',
    projectId: 'round1b',
    storageBucket: 'round1b.appspot.com',
    iosBundleId: 'com.example.round1b',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAJPzTS9aGQCqqQdWQbnPPXJJOibANVzm4',
    appId: '1:940732082733:ios:8cc12ed61ea607e21de6a4',
    messagingSenderId: '940732082733',
    projectId: 'round1b',
    storageBucket: 'round1b.appspot.com',
    iosBundleId: 'com.example.round1b',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC5Euh0rhTJ4xXuAeaYxXpOhkK0LG-oFv8',
    appId: '1:940732082733:web:5e6e0e56ac1da9c01de6a4',
    messagingSenderId: '940732082733',
    projectId: 'round1b',
    authDomain: 'round1b.firebaseapp.com',
    storageBucket: 'round1b.appspot.com',
    measurementId: 'G-CFWG1DH3GE',
  );

}