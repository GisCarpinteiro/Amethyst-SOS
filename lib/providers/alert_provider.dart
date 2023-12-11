import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:vistas_amatista/controller/alert_controller.dart';
import 'package:vistas_amatista/controller/firestore_controller.dart';
import 'package:vistas_amatista/controller/shared_preferences_manager.dart';
import 'package:vistas_amatista/models/alert.dart';
import 'package:vistas_amatista/services/smartwatch_service.dart';

class AlertProvider with ChangeNotifier {
  List<Alert> alerts = [];
  int toleranceTimeOption = 0;
  bool isAlertEditionContext = false;
  int? targetAlertId;
  final alertNameCtrl = TextEditingController();
  final messageCtrl = TextEditingController();
  int toleranceTime = 30;
  bool shareLocation = false;
  Map<String, dynamic> triggers = {
    'backtap_trigger': true,
    'button_trigger': false,
    'smartwatch_trigger': false,
    'disconnection_trigger': true,
    'smartwatch_disconnection_trigger': false,
    'voice_trigger': false,
  };

  void getAlertsLists() {
    alerts = AlertController.getAlerts();
  }

  void editionContext(Alert targetAlert) {
    targetAlertId = targetAlert.id;
    isAlertEditionContext = true;
    alertNameCtrl.text = targetAlert.name;
    messageCtrl.text = targetAlert.message;
    toleranceTime = targetAlert.toleranceSeconds;
    shareLocation = targetAlert.shareLocation;
    triggers = targetAlert.triggers;
  }

  void creationContext() {
    isAlertEditionContext = false;
    alertNameCtrl.text = "Nueva Alerta";
    messageCtrl.text = "Necesito tu ayuda!";
    toleranceTime = 30;
    shareLocation = false;
    triggers = {
      'backtap_trigger': true,
      'button_trigger': false,
      'smartwatch_trigger': false,
      'disconnection_trigger': true,
      'smartwatch_disconnection_trigger': false,
      'voice_trigger': false,
    };
  }

  void wizardDefaultAlertCreationContext() {
    isAlertEditionContext = false;
    alertNameCtrl.text = "Mi Alerta";
    toleranceTime = 30;
    shareLocation = true;
    triggers = {
      'backtap_trigger': false,
      'button_trigger': true,
      'smartwatch_trigger': false,
      'disconnection_trigger': true,
      'smartwatch_disconnection_trigger': false,
      'voice_trigger': false,
    };
  }

  void changeToleranceTime() {
    final values = [10, 30, 60, 120, 300];
    toleranceTime = values[toleranceTimeOption];
  }

  Future<String?> deleteAlert(Alert targetAlert) async {
    //First we check if the alert was on the list to delete it
    List<Alert> alertsCopy = List.from(alerts, growable: true);
    if (alertsCopy.remove(targetAlert)) {
      // If successfully removed, then we update the list on firebase
      if (await FirestoreController.updateAlertList(alertsCopy)) {
        alerts = alertsCopy;
        SharedPrefsManager.updateAlertList(alerts);
        FlutterLogs.logInfo("AlertsProvider", "deleteAlert", "SUCCESS: The alert has ben deleted!");
        if (SmartwatchService.automaticSync) {
          SmartwatchService.sendSyncMessage();
        }
        notifyListeners();
        return null;
      } else {
        FlutterLogs.logError("AlertsProvider", "deleteAlert", "FAILURE: The alert couldn't be deleted on firestore");
        return "La alerta no pudo eliminarse de forma permanente, revise su conexión a internet e intente de nuevo";
      }
    } else {
      return "No pudo eliminarse la alerta! reinicie sesión";
    }
  }

  Future<String?> saveAlert() async {
    // We validate that the fields of name and message are not blank
    if (alertNameCtrl.text == "") {
      return "La alerta debe tener un nombre!";
    } else if (messageCtrl.text == "") {
      return "La alerta debe de tener un mensaje!";
    }

    List<Alert> alertsCopy = List.from(alerts, growable: true);
    if (isAlertEditionContext) {
      //We need to remove the old version of the alert
      for (Alert alert in alertsCopy) {
        if (alert.id == targetAlertId) {
          alertsCopy.remove(alert);
          break;
        }
      }
    } else {
      //The limit of configured alerts is 3 so we need to check if there are already 3 alerts
      if (alertsCopy.length > 2) return "Solo puede configurar 3 alertas, elimine una antes";
    }
    Set<int> avaliableIds = {0, 1, 2};

    // We need to check that the alert name was not already picked and also determine available Id's for creation context
    for (Alert existingAlert in alertsCopy) {
      if (alertNameCtrl.text == existingAlert.name) return "Ya existe una alerta con ese nombre";
      if (!isAlertEditionContext) avaliableIds.remove(existingAlert.id);
    }
    // if al the conditions were meet, then we procede to build the new alert to add
    alertsCopy.add(Alert(
        id: isAlertEditionContext ? targetAlertId : avaliableIds.first,
        name: alertNameCtrl.text,
        message: messageCtrl.text,
        shareLocation: shareLocation,
        toleranceSeconds: toleranceTime,
        triggers: triggers));

    if (await FirestoreController.updateAlertList(alertsCopy)) {
      // If succesfull then we update shared preferences data locally:
      SharedPrefsManager.updateAlertList(alertsCopy);
      if (SmartwatchService.automaticSync) {
          SmartwatchService.sendSyncMessage();
      }
      isAlertEditionContext
          ? FlutterLogs.logInfo("AlertProvider", "saveAlert", "SUCCESS the alert has been updated!!!")
          : FlutterLogs.logInfo("AlertProvider", "saveALert", "SUCCESS the aelrt has been created!!!");
      notifyListeners();
      return null;
    } else {
      FlutterLogs.logError("AlertProvider", "SaveAlert",
          "FAILURE: The alert hasn't been created/updated due to an error when trying to update the firestore data");
      return isAlertEditionContext
          ? "Ah ocurrido un error al actualizar la alerta de forma permanente. Revise su conexión a internet o intente más tarde"
          : "Ah ocurrido un error al crear la alerta de forma permanente. Revise su conexión a internet o intente más tarde";
    }
  }
}
