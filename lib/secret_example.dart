// Package imports:
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

// Secret class
class Secret {
  static const FirebaseOptions firebaseOptionsAndroid = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: '',
    storageBucket: '',
  );

  static const FirebaseOptions firebaseOptionsIOS = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: '',
    storageBucket: '',
    iosBundleId: '',
  );
}
