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
    apiKey: 'AIzaSyBNbOXOkJZBT8iZFyR2QDq6SFD_IKBgWIY',
    appId: '1:137464289879:web:6c1e76d2df798094dc6112',
    messagingSenderId: '137464289879',
    projectId: 'mikilonotes',
    authDomain: 'mikilonotes.firebaseapp.com',
    storageBucket: 'mikilonotes.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDybxqUUXh0BSEbB4ysEbWq07xCu4qd-Yw',
    appId: '1:137464289879:android:bfde74d37db88255dc6112',
    messagingSenderId: '137464289879',
    projectId: 'mikilonotes',
    storageBucket: 'mikilonotes.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAgR4vUHAdN6LWIjshePNvSjVBGHRd4Dt0',
    appId: '1:137464289879:ios:b707449ce3be083cdc6112',
    messagingSenderId: '137464289879',
    projectId: 'mikilonotes',
    storageBucket: 'mikilonotes.appspot.com',
    iosClientId: '137464289879-t5a0ip9bu2m9s3ofv355e2jpc0gth315.apps.googleusercontent.com',
    iosBundleId: 'com.example.mikoloNotes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAgR4vUHAdN6LWIjshePNvSjVBGHRd4Dt0',
    appId: '1:137464289879:ios:fba7139391135e20dc6112',
    messagingSenderId: '137464289879',
    projectId: 'mikilonotes',
    storageBucket: 'mikilonotes.appspot.com',
    iosClientId: '137464289879-b8i1i97kkql8v6hpfar8tia4n2cvmo5p.apps.googleusercontent.com',
    iosBundleId: 'com.example.mikoloNotes.RunnerTests',
  );
}