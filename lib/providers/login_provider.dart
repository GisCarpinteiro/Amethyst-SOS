import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:vistas_amatista/controller/fireauth_controller.dart';
import 'package:vistas_amatista/controller/firestore_controller.dart';

class LoginProvider with ChangeNotifier {
  String email = "";
  String password = "";

  Future<bool> logWithEmail({String? email, String? password}) async {
    email ?? (email = "example@gmail.com");
    password ?? (password = "holamundo");
    if (await FireAuthController.logByEmailMethod(email: email, password: password)) {
      if (await FirestoreController.searchAccount(email, password)) {
        FlutterLogs.logInfo("LoginProvider", "logWithEmail", "SUCCESS: Logging operations complete, going to Home");
        return true;
      }
    }
    FlutterLogs.logError("LoginProvider", "logWithEmail", "FAILURE: Logging operations failed, try to log again");
    return false;
  }
}
