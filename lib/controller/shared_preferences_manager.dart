import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vistas_amatista/controller/group_controller.dart';
import 'package:vistas_amatista/controller/alert_controller.dart';
import 'package:vistas_amatista/controller/firestore_controller.dart';
import 'package:vistas_amatista/controller/routines_controller.dart';

/* About this Class: Shared Preferences is a library used to store data locally to retrieve it later when needed*/

class SharedPrefsManager {
  static SharedPreferences? _sharedPrefs;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static init() {
    restoreAllConfigsFromFirebase();
  }

  // This getter is the used to acces shared preferences AKA local data copies from all other places in the APP. That's why _sharedPrefs is an static variable.
  static SharedPreferences? get instance => _sharedPrefs;

  // This method is used to get all the configurations from firebase to the shared preferences variables on the app
  static Future<bool> restoreAllConfigsFromFirebase({String? password, String? email}) async {
    FlutterLogs.logInfo("SharedPrefsManager", "restoreAllCongfigsFromFirebase", "Starting local backup for account");
    String groupsData = await GroupController.getGroupsAsString(); // ! Replace with Firebase
    String alertsData = await AlertController.getAlertsAsString(); // ! Replace with Firebase
    String routinesData = await RoutineController.getRoutinesAsString(); // ! Replace with Firebase

    _sharedPrefs ??= await SharedPreferences.getInstance();
    await _sharedPrefs?.setString('groups', groupsData);
    await _sharedPrefs?.setString('alerts', alertsData);
    await _sharedPrefs?.setString('routines', routinesData);
    return true;
  }
}
