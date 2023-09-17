import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:vistas_amatista/models/alert.dart';
import 'dart:io';

// This class has the methods to update te JSON of the local User Data
class AlertController {
  // This method restores/creates the data based on a new logged fetching from the remote DB.
  static restoreAll() {}

  // This method updates the local alerts data.
  static updateAlert(Alert targetAlert) {}

  // This method adds a new alert to local alerts data
  static addAlert(Alert newAlert) {
    String jsonFormatAlert = "null";
    jsonFormatAlert = jsonEncode(newAlert);

    File('lib/data/alerts.json').readAsString().then((alertsJson) {
      alertsJson.trimRight();
      alertsJson = alertsJson.replaceRange(alertsJson.length - 1, null, '');
      jsonFormatAlert = "${alertsJson},${jsonFormatAlert}]";

      File('lib/data/alerts.json').writeAsString(jsonFormatAlert, encoding: Utf8Codec());

      File('lib/data/alerts.json').readAsString().then((alertsJson) {
        print(jsonDecode(alertsJson));
      });
    });
  }

  static deleteAlert(int id) {
    // TODO: eliminar alerta
  }
  // This method obtains all the alerts from local alerts data
  static List<Alert> getAllAlerts() {
    List<Alert> alerts = List.empty(growable: true);

    //Read from the alerts json
    rootBundle.loadString('lib/data/alerts.json').then((input) {
      final parsedJson = jsonDecode(input);
      // Add each one to the alert list
      for (var alert in parsedJson) {
        alerts.add(Alert.fromJson(alert));
      }
      return alerts;
    });

    // JSON String to objects
    return alerts;
  }
}
