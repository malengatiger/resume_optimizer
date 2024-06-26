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
    apiKey: 'AIzaSyDgi7UPNDwAYIL6UgGZ10xQR4yqhXDADBY',
    appId: '1:413705168066:web:aaa6ddc7077221e853075b',
    messagingSenderId: '413705168066',
    projectId: 'sgela-ai-33',
    authDomain: 'sgela-ai-33.firebaseapp.com',
    storageBucket: 'sgela-ai-33.appspot.com',
    measurementId: 'G-YXD66KLEQ6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBjVYccOuUD9ucbwbkYTRHDHymoVTNBQsw',
    appId: '1:413705168066:android:c58aafae6bfd5b8553075b',
    messagingSenderId: '413705168066',
    projectId: 'sgela-ai-33',
    storageBucket: 'sgela-ai-33.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCZx8B3sOgilvxvOwtjfi3Zy0HiU3SikvM',
    appId: '1:413705168066:ios:50d8d665fe706e8753075b',
    messagingSenderId: '413705168066',
    projectId: 'sgela-ai-33',
    storageBucket: 'sgela-ai-33.appspot.com',
    androidClientId: '413705168066-hjrnikl476fb9baei10k36c523p81vih.apps.googleusercontent.com',
    iosClientId: '413705168066-a8j54ieq3ir74d7m7ojs5dsg3ppd4e15.apps.googleusercontent.com',
    iosBundleId: 'com.boha.resumeOptimizer',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCZx8B3sOgilvxvOwtjfi3Zy0HiU3SikvM',
    appId: '1:413705168066:ios:e1bca995b1f5c3e753075b',
    messagingSenderId: '413705168066',
    projectId: 'sgela-ai-33',
    storageBucket: 'sgela-ai-33.appspot.com',
    androidClientId: '413705168066-hjrnikl476fb9baei10k36c523p81vih.apps.googleusercontent.com',
    iosClientId: '413705168066-8k8cs54833spfv0qesr1p6ru97kc56ed.apps.googleusercontent.com',
    iosBundleId: 'com.boha.resumeOptimizer.RunnerTests',
  );
}
