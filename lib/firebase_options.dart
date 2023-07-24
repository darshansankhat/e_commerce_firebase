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
    apiKey: 'AIzaSyDA4a7eyDBj5842JMNWVlD-BrIRueN9yds',
    appId: '1:197751656602:web:6dfd5c686f5fd25353cf23',
    messagingSenderId: '197751656602',
    projectId: 'e-commerce-bae61',
    authDomain: 'e-commerce-bae61.firebaseapp.com',
    storageBucket: 'e-commerce-bae61.appspot.com',
    measurementId: 'G-85T3ZJP339',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCyNPskqQ6579pYjZXRnYVmgAxECuV0wvM',
    appId: '1:197751656602:android:318d9a63f3b15f3c53cf23',
    messagingSenderId: '197751656602',
    projectId: 'e-commerce-bae61',
    storageBucket: 'e-commerce-bae61.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCuNc1cRsyPTcNbtFQJzO2G-w4fep2TmGU',
    appId: '1:197751656602:ios:7dd1b0adfd52b88f53cf23',
    messagingSenderId: '197751656602',
    projectId: 'e-commerce-bae61',
    storageBucket: 'e-commerce-bae61.appspot.com',
    iosClientId: '197751656602-o52jtk3lok7vsp02vfaif1sf7s03lr6n.apps.googleusercontent.com',
    iosBundleId: 'com.example.eCommerceFirebase',
  );
}
