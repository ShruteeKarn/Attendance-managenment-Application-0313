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
    apiKey: 'AIzaSyC7qIzU7bb-SwA3XguIwhLb82zP0sWjx7w',
    appId: '1:796732922348:web:2367d3f16478b0a3e588c9',
    messagingSenderId: '796732922348',
    projectId: 'rkams-d9279',
    authDomain: 'rkams-d9279.firebaseapp.com',
    databaseURL: 'https://rkams-d9279-default-rtdb.firebaseio.com',
    storageBucket: 'rkams-d9279.appspot.com',
    measurementId: 'G-0BQVT0VHK7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD7Nw2-r3l8J15YzqZ5tfHDmYBd1siItgA',
    appId: '1:796732922348:ios:1f74e1656d9f9ec3e588c9',
    messagingSenderId: '796732922348',
    projectId: 'rkams-d9279',
    databaseURL: 'https://rkams-d9279-default-rtdb.firebaseio.com',
    storageBucket: 'rkams-d9279.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD7Nw2-r3l8J15YzqZ5tfHDmYBd1siItgA',
    appId: '1:796732922348:ios:1f74e1656d9f9ec3e588c9',
    messagingSenderId: '796732922348',
    projectId: 'rkams-d9279',
    databaseURL: 'https://rkams-d9279-default-rtdb.firebaseio.com',
    storageBucket: 'rkams-d9279.appspot.com',
    iosBundleId: 'com.example.ams',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD7Nw2-r3l8J15YzqZ5tfHDmYBd1siItgA',
    appId: '1:796732922348:ios:97c56c2b5e2ae858e588c9',
    messagingSenderId: '796732922348',
    projectId: 'rkams-d9279',
    databaseURL: 'https://rkams-d9279-default-rtdb.firebaseio.com',
    storageBucket: 'rkams-d9279.appspot.com',
    iosBundleId: 'com.example.ams.RunnerTests',
  );
}
