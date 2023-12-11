import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vistas_amatista/controller/shared_preferences_manager.dart';
import 'package:vistas_amatista/models/alert.dart';

// This class has the methods to update te JSON of the local User Data
class AlertController {
  static Future<String> getAlertsAsString(QueryDocumentSnapshot<Object?> user) async {
    try {
      final data = jsonEncode(user.get("alerts")).toString();
      return data;
    } on StateError catch (e) {
      FlutterLogs.logWarn(
          "AlertController", "getAlertsAsString", "Couln't retrieve alerts from firebase with exception: ${e.message}");
    }
    return "";
  }

  static updateAlertListOnFirebase({required List<Alert> newAlertList, required String userId}) {
    // We need a reference for the users collection
    CollectionReference users = FirebaseFirestore.instance.collection('User');
    // Firebase only accepts maps so we need to convert the list of routines to a list of maps
    List<Map<dynamic, dynamic>> alertsListAsMaps = List.empty(growable: true);
    for (Alert alert in newAlertList) {
      alertsListAsMaps.add(alert.toJson());
    }
    //Then we send te request to firebase we the list of alerts as maps
    return users.doc(userId).update({'alerts': alertsListAsMaps}).then((value) {
      FlutterLogs.logInfo("AlertsController", "updateAlertsListOnFirebase",
          "The list of alerts has been updated succesfully with data: $alertsListAsMaps");
      return true;
    }).catchError((error) {
      FlutterLogs.logError("AlertsController", "AlertsGroupListOnFirebase",
          "Error while trying to update the list of alerts on firestore with description: $error");
      return false;
    });
  }

  // We get all the values from JSON configs
  static List<Alert> getAlerts() {
    SharedPreferences? sharedPreferences = SharedPrefsManager.sharedInstance;
    List<Alert> alerts = List.empty(growable: true);

    String? alertsAsString = sharedPreferences?.getString('alerts');
    final paresedJson = jsonDecode(alertsAsString ??
        "[]"); //TODO No retornar un [], hacer reintentos de obtener la info desde la BD o mostrar mensaje de error
    for (var alert in paresedJson) {
      alerts.add(Alert.fromJson(alert));
    }

    return alerts;
  }

  static Alert? getAlertById(int id) {
    List<Alert> alerts = getAlerts();
    for (Alert target in alerts) {
      if (target.id == id) return target;
    }
    return null;
  }
}
