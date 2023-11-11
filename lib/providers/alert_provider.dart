import 'package:flutter/foundation.dart';
import 'package:vistas_amatista/controller/alert_controller.dart';
import 'package:vistas_amatista/models/alert.dart';

class AlertProvider with ChangeNotifier {
  List<Alert> alerts = [];
  int toleranceTimeOption = 0;
  bool isAlertEditionContext = false;
  String name = "";
  String message = "";
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
    isAlertEditionContext = true;
    name = targetAlert.name;
    message = targetAlert.message;
    toleranceTime = targetAlert.toleranceSeconds;
    shareLocation = targetAlert.shareLocation;
    triggers = targetAlert.triggers;
  }

  void creationContext() {
    isAlertEditionContext = false;
    name = "";
    message = "";
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

  void changeToleranceTime() {
    final values = [10, 30, 60, 120, 300];
    toleranceTime = values[toleranceTimeOption];
  }

  Future<String?> deleteAlert(Alert targetAlert) async {
    return null;
  }
}
