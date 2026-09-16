import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'PASTE_FIREBASE_WEB_API_KEY',
    appId: 'PASTE_FIREBASE_WEB_APP_ID',
    messagingSenderId: 'PASTE_FIREBASE_MESSAGING_SENDER_ID',
    projectId: 'PASTE_FIREBASE_PROJECT_ID',
    authDomain: 'PASTE_FIREBASE_PROJECT_ID.firebaseapp.com',
    storageBucket: 'PASTE_FIREBASE_PROJECT_ID.appspot.com',
  );
}
