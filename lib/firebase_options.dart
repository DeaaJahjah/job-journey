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
    apiKey: 'AIzaSyCk_YiSTHv_ZGfZNNozSk2h9I1L4NBil5E',
    appId: '1:675581530463:web:6c4cf941a4b31c802226ea',
    messagingSenderId: '675581530463',
    projectId: 'job-journey-68723',
    authDomain: 'job-journey-68723.firebaseapp.com',
    storageBucket: 'job-journey-68723.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCyIjdmJvigzrrEy6Tr1BpZPXVSp_udUgo',
    appId: '1:675581530463:android:72eb7446be6c673f2226ea',
    messagingSenderId: '675581530463',
    projectId: 'job-journey-68723',
    storageBucket: 'job-journey-68723.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCO6aBasB9MflQ4_0w_fi3egQRQ2iLyRRI',
    appId: '1:675581530463:ios:809837e8288fe5292226ea',
    messagingSenderId: '675581530463',
    projectId: 'job-journey-68723',
    storageBucket: 'job-journey-68723.appspot.com',
    iosBundleId: 'com.example.jobJourney',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCO6aBasB9MflQ4_0w_fi3egQRQ2iLyRRI',
    appId: '1:675581530463:ios:809837e8288fe5292226ea',
    messagingSenderId: '675581530463',
    projectId: 'job-journey-68723',
    storageBucket: 'job-journey-68723.appspot.com',
    iosBundleId: 'com.example.jobJourney',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCk_YiSTHv_ZGfZNNozSk2h9I1L4NBil5E',
    appId: '1:675581530463:web:721309949e23b3112226ea',
    messagingSenderId: '675581530463',
    projectId: 'job-journey-68723',
    authDomain: 'job-journey-68723.firebaseapp.com',
    storageBucket: 'job-journey-68723.appspot.com',
  );
}
