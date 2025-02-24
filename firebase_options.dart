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
    databaseURL: "https://testing-cli-421ab-default-rtdb.firebaseio.com",
    apiKey: 'AIzaSyA6uPBtQHC2vQMYRQjIxb_tUSU0sUjw7Gw',
    appId: '1:62480567502:web:62a81b57f979c979d6549f',
    messagingSenderId: '62480567502',
    projectId: 'testing-cli-421ab',
    authDomain: 'testing-cli-421ab.firebaseapp.com',
    storageBucket: 'testing-cli-421ab.appspot.com',
    measurementId: 'G-0D23158JX0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCkgokZsLSptKs1HLbbOZo5zR5dmkkawSY',
    appId: '1:62480567502:android:cc623adf8b2b2225d6549f',
    messagingSenderId: '62480567502',
    projectId: 'testing-cli-421ab',
    storageBucket: 'testing-cli-421ab.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAvXuntsJY_6eVE_4xNmGuYC3Di_mvrnKQ',
    appId: '1:62480567502:ios:c9c924c1e367f059d6549f',
    messagingSenderId: '62480567502',
    projectId: 'testing-cli-421ab',
    storageBucket: 'testing-cli-421ab.appspot.com',
    iosBundleId: 'com.example.firebaseapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAvXuntsJY_6eVE_4xNmGuYC3Di_mvrnKQ',
    appId: '1:62480567502:ios:c9c924c1e367f059d6549f',
    messagingSenderId: '62480567502',
    projectId: 'testing-cli-421ab',
    storageBucket: 'testing-cli-421ab.appspot.com',
    iosBundleId: 'com.example.firebaseapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA6uPBtQHC2vQMYRQjIxb_tUSU0sUjw7Gw',
    appId: '1:62480567502:web:616646c635f4ab40d6549f',
    messagingSenderId: '62480567502',
    projectId: 'testing-cli-421ab',
    authDomain: 'testing-cli-421ab.firebaseapp.com',
    storageBucket: 'testing-cli-421ab.appspot.com',
    measurementId: 'G-CEK3FP3MH8',
  );
}
