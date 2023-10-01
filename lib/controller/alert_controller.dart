import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vistas_amatista/controller/shared_preferences_manager.dart';
import 'package:vistas_amatista/models/alert.dart';
import 'dart:io';

// This class has the methods to update te JSON of the local User Data
class AlertController {
  // This method restores/creates the data based on a new logged fetching from the remote DB.
  static restoreAll() {}

  // This method updates the local alerts data.
  static updateAlert(Alert targetAlert) {}

  static Future<String> getAlertsAsString() async {
    // TODO: Esto eso solo la simulación de una base de datos remota ;)
    return rootBundle.loadString('lib/data/alerts.json');
  }

  // This method adds a new alert to local alerts data
  static addAlert(Alert newAlert) {}

  static deleteAlert(int id) {
    // TODO: eliminar alerta
  }

  // We get all the values from JSON configs
  static List<Alert> getAlerts() {
    SharedPreferences? sharedPreferences = SharedPrefsManager.instance;
    List<Alert> alerts = List.empty(growable: true);

    String? alertsAsString = sharedPreferences?.getString('alerts');
    final paresedJson = jsonDecode(
        alertsAsString ?? "[]"); //TODO No retornar un [], hacer reintentos de obtener la info desde la BD o mostrar mensaje de error
    for (var alerts in paresedJson) {
      alerts.add(Alert.fromJson(alerts));
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
