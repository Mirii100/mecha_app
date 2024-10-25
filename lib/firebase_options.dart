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
    apiKey: 'AIzaSyC-9eHomnu9bryiKTOf6azMR7ZC7wgEnTU',
    appId: '1:935332776626:web:b9fd64ac2d5c889ce317ab',
    messagingSenderId: '935332776626',
    projectId: 'mechaapp-5a0bf',
    authDomain: 'mechaapp-5a0bf.firebaseapp.com',
    storageBucket: 'mechaapp-5a0bf.appspot.com',
    measurementId: 'G-3QKBD836S7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAUjzWiGYgOGYdoQxTj_UQXkmAAnQN_azw',
    appId: '1:935332776626:android:279793782af9021fe317ab',
    messagingSenderId: '935332776626',
    projectId: 'mechaapp-5a0bf',
    storageBucket: 'mechaapp-5a0bf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCBRH-SretiEXI1Z9QH1DWWUDekE1-o8PA',
    appId: '1:935332776626:ios:0eea4547101f055ce317ab',
    messagingSenderId: '935332776626',
    projectId: 'mechaapp-5a0bf',
    storageBucket: 'mechaapp-5a0bf.appspot.com',
    iosBundleId: 'com.example.mechaApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCBRH-SretiEXI1Z9QH1DWWUDekE1-o8PA',
    appId: '1:935332776626:ios:0eea4547101f055ce317ab',
    messagingSenderId: '935332776626',
    projectId: 'mechaapp-5a0bf',
    storageBucket: 'mechaapp-5a0bf.appspot.com',
    iosBundleId: 'com.example.mechaApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC-9eHomnu9bryiKTOf6azMR7ZC7wgEnTU',
    appId: '1:935332776626:web:3771a6bec38763c1e317ab',
    messagingSenderId: '935332776626',
    projectId: 'mechaapp-5a0bf',
    authDomain: 'mechaapp-5a0bf.firebaseapp.com',
    storageBucket: 'mechaapp-5a0bf.appspot.com',
    measurementId: 'G-9Z1WHF74FQ',
  );

}