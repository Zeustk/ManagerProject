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
    apiKey: 'AIzaSyBidGE6St_k7x_o0n_GbvpRzyVvlZzUFgA',
    appId: '1:979147010184:web:b9390ffdf043a23b55af3d',
    messagingSenderId: '979147010184',
    projectId: 'projecmanajer',
    authDomain: 'projecmanajer.firebaseapp.com',
    storageBucket: 'projecmanajer.appspot.com',
    measurementId: 'G-QNKJ7E6BHN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC7z1fMJOyCyXuzz_kMzuoKqwcWsnYQz3U',
    appId: '1:979147010184:android:55f8b03ae256c86255af3d',
    messagingSenderId: '979147010184',
    projectId: 'projecmanajer',
    storageBucket: 'projecmanajer.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC4EOTtFDNleTr2P6pVJnLHH7ZUdXELMY4',
    appId: '1:979147010184:ios:a4a25cd7d0c9b9aa55af3d',
    messagingSenderId: '979147010184',
    projectId: 'projecmanajer',
    storageBucket: 'projecmanajer.appspot.com',
    iosBundleId: 'com.example.login',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC4EOTtFDNleTr2P6pVJnLHH7ZUdXELMY4',
    appId: '1:979147010184:ios:a4a25cd7d0c9b9aa55af3d',
    messagingSenderId: '979147010184',
    projectId: 'projecmanajer',
    storageBucket: 'projecmanajer.appspot.com',
    iosBundleId: 'com.example.login',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBidGE6St_k7x_o0n_GbvpRzyVvlZzUFgA',
    appId: '1:979147010184:web:be9bb1a8771e8fc555af3d',
    messagingSenderId: '979147010184',
    projectId: 'projecmanajer',
    authDomain: 'projecmanajer.firebaseapp.com',
    storageBucket: 'projecmanajer.appspot.com',
    measurementId: 'G-XMTL5K1X6Q',
  );

}