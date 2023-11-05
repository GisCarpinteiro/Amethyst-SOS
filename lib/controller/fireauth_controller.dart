import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_logs/flutter_logs.dart';

// This class is used to search, create, delete or update info from Firebase Authentification. Is used along FirestoreController for many operations
class FireAuthController {
  // This method is used to fetch for the user by their email and password, if there's one the config data for the user is restored, if not show an error on screen
  static Future<bool> logByEmailMethod({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        FlutterLogs.logWarn("FireAuthController", "logByEmailMethod", "User for those credentials hasn't been found");
      } else if (e.code == 'wrong-password') {
        FlutterLogs.logWarn("FireAuthController", "logByEmailMethod", "The password for that user is not correct");
      }
      return false;
    }
    FlutterLogs.logInfo("FireAuthController", "logByEmailMethod", "Successfull Authentification");
    return true;
  }
}
