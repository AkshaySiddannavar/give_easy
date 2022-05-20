// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

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
    apiKey: 'AIzaSyCk5mm5Kijm-xVGbMymePdnBqDTKhUbr_Q',
    appId: '1:976142245865:web:51997d54c7e2fe69b53578',
    messagingSenderId: '976142245865',
    projectId: 'give-easy',
    authDomain: 'give-easy.firebaseapp.com',
    storageBucket: 'give-easy.appspot.com',
    measurementId: 'G-M4HKFPT456',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDslYVkfnXHJ16n7g4Be_AFoEcpGwri_8Q',
    appId: '1:976142245865:android:5d1f45b04809af4fb53578',
    messagingSenderId: '976142245865',
    projectId: 'give-easy',
    storageBucket: 'give-easy.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBlvC-Uhw4sYfK4AUDlp4bJWSS3BvC7rH0',
    appId: '1:976142245865:ios:053a9f1e2009e265b53578',
    messagingSenderId: '976142245865',
    projectId: 'give-easy',
    storageBucket: 'give-easy.appspot.com',
    iosClientId:
        '976142245865-baapjk0nopvs2c0e8jk7gm53cgfk5i6e.apps.googleusercontent.com',
    iosBundleId: 'giveeasy.co.giveEasy',
  );
}