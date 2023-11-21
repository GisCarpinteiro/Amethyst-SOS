import 'package:flutter/material.dart';
import 'package:vistas_amatista/controller/shared_preferences_manager.dart';

class AppSettingsProvider with ChangeNotifier {
  final usernameCtlr = TextEditingController();
  final emailCtlr = TextEditingController();
  final phoneCtlr = TextEditingController();
  final currentPasswordCtlr = TextEditingController();
  final newPasswordCtlr = TextEditingController();
  final confirmPasswordCtlr = TextEditingController();
  String password = "";
  bool darkTheme = false;
  bool mapOnHome = true;

  initScreen() async {
    final sharedPrefs = SharedPrefsManager.sharedInstance;
    final secureSharedPrefs = SharedPrefsManager.secureSharedInstance;
    if (sharedPrefs != null) {
      usernameCtlr.text = sharedPrefs.getString("name") ?? "";
      phoneCtlr.text = sharedPrefs.getString("phone") ?? "";
      emailCtlr.text = sharedPrefs.getString("email") ?? "";
    } else {
      usernameCtlr.text = "";
      phoneCtlr.text = "";
      emailCtlr.text = "";
    }
    if (secureSharedPrefs != null) {
      password = await secureSharedPrefs.getString("password") ?? "";
    }
    darkTheme = false;
  }

  changeDarkTheme(bool value){
    darkTheme = value;
    notifyListeners();
  }

  changeMapOnHome(bool value){
    mapOnHome = value;
    notifyListeners();
  }
}
