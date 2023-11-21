import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vistas_amatista/controller/group_controller.dart';
import 'package:vistas_amatista/controller/alert_controller.dart';
import 'package:vistas_amatista/controller/routines_controller.dart';
import 'package:vistas_amatista/models/alert.dart';
import 'package:vistas_amatista/models/group.dart';
import 'package:vistas_amatista/models/routine.dart';

/* About this Class: Shared Preferences is a library used to store data locally to retrieve it later when needed*/

class SharedPrefsManager {
  static SharedPreferences? _sharedPrefs;
  static SecureSharedPref? _secureSharedPreferences;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  static initSharedPreferencesInstance() async {
    _secureSharedPreferences = await SecureSharedPref.getInstance();
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  // This getter is the used to acces shared preferences AKA local data copies from all other places in the APP. That's why _sharedPrefs is an static variable.
  static SharedPreferences? get sharedInstance => _sharedPrefs;
  static SecureSharedPref? get secureSharedInstance => _secureSharedPreferences;

  // This method receives an object with all the User data to store it locally through SharedPreferences.
  static Future<bool> backupFromFirestoreToLocal(QueryDocumentSnapshot<Object?> user) async {
    FlutterLogs.logInfo("SharedPrefsManager", "restoreAllCongfigsFromFirebase", "Starting local backup for account");
    String groupsData = await GroupController.getGroupsAsString(user);
    String alertsData = await AlertController.getAlertsAsString(user); 
    String routinesData = await RoutineController.getRoutinesAsString(user);
    
    _sharedPrefs ??= await SharedPreferences.getInstance();
    await _sharedPrefs?.setString('groups', groupsData == "" ? "[]" : groupsData);
    await _sharedPrefs?.setString('alerts', alertsData == "" ? "[]" : alertsData);
    await _sharedPrefs?.setString('routines', routinesData == "" ? "[]" : routinesData);
    await _sharedPrefs?.setString('name', user.get("name"));
    await _sharedPrefs?.setString('email', user.get("email"));
    await _sharedPrefs?.setString('phone', user.get("phone"));

    return true;
  }

  static updateGroupList(List<Group> newGroupList) async {
    String groupsData = jsonEncode(newGroupList).toString();
    FlutterLogs.logInfo("SharedPrefsManager", "updateGroupList", "Updating group list locally with SharedPreferences");
    await _sharedPrefs?.setString('groups', groupsData == "" ? "[]" : groupsData);
  }

  static updateRoutineList(List<Routine> newRoutineList) async {
    String routinesData = jsonEncode(newRoutineList).toString();
    FlutterLogs.logInfo("SharedPrefsManager", "updateRoutineList", "Updating routine list locally with SharedPreferences");
    await _sharedPrefs?.setString('routines', routinesData == "" ? "[]" : routinesData);
  }

  static updateAlertList(List<Alert> newAlertList) async {
    String alertData = jsonEncode(newAlertList).toString();
    FlutterLogs.logInfo("SharedPrefsManager", "updateAlertList", "Updating alert list locally with SharedPreferences");
    await _sharedPrefs?.setString('alerts', alertData == "" ? "[]" : alertData);
  }

}
