import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:vistas_amatista/controller/firestore_controller.dart';
import 'package:vistas_amatista/models/user.dart' as models;

class AuthController {
  static Future<bool> createAccount({required models.User user, required String password}) async {
    late String uid;
    try {
      FlutterLogs.logInfo("AuthController", "CreateAccount", "Trying to create the account on fireAuth");
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: user.email, password: password);
      uid = userCredential.user!.uid;
      FlutterLogs.logInfo("AuthController", "CreateAccount (firebaseAuth)", "SUCCESS. Account created on fireAuth");
    } catch (e) {
      FlutterLogs.logError("AuthController", "CreateAccount",
          "FAILURE. There was an error when trying to create the account on fireauth: $e");
      return false;
    }

    // If the creation on firebase auth is succesfull then we create the user on firestore:
    if (await FirestoreController.createAccount(uid, user)) {
      FirestoreController.getUserData(user.email, password);
      return true;
    } else {
      return false;
    }
  }
}
