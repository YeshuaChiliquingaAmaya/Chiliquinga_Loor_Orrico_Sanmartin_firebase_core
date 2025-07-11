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
    apiKey: 'AIzaSyAZjr9jo0SoL2vjjJYY0ESDW7wuUbZb74M',
    appId: '1:136182049154:web:d52b3afa30388d1baa879b',
    messagingSenderId: '136182049154',
    projectId: 'tiendalocalapp',
    authDomain: 'tiendalocalapp.firebaseapp.com',
    storageBucket: 'tiendalocalapp.firebasestorage.app',
    measurementId: 'G-J4550M4C54',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAurLBSgnsdjf56aXGVdI-7MwnQKtBK30A',
    appId: '1:136182049154:android:0a1fa03bc3ef2913aa879b',
    messagingSenderId: '136182049154',
    projectId: 'tiendalocalapp',
    storageBucket: 'tiendalocalapp.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDkwqQ98rWX4N9r1-Iq2_37EfRuFSVDwdI',
    appId: '1:136182049154:ios:e4c6c37416ee0a32aa879b',
    messagingSenderId: '136182049154',
    projectId: 'tiendalocalapp',
    storageBucket: 'tiendalocalapp.firebasestorage.app',
    iosBundleId: 'com.example.firebaseCore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDkwqQ98rWX4N9r1-Iq2_37EfRuFSVDwdI',
    appId: '1:136182049154:ios:e4c6c37416ee0a32aa879b',
    messagingSenderId: '136182049154',
    projectId: 'tiendalocalapp',
    storageBucket: 'tiendalocalapp.firebasestorage.app',
    iosBundleId: 'com.example.firebaseCore',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAZjr9jo0SoL2vjjJYY0ESDW7wuUbZb74M',
    appId: '1:136182049154:web:33ef00baef7d4c5aaa879b',
    messagingSenderId: '136182049154',
    projectId: 'tiendalocalapp',
    authDomain: 'tiendalocalapp.firebaseapp.com',
    storageBucket: 'tiendalocalapp.firebasestorage.app',
    measurementId: 'G-EC38ZM15W8',
  );
}
