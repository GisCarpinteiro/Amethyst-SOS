import 'package:flutter/material.dart';
import 'package:vistas_amatista/api/rest_alert_connector.dart';
import 'package:vistas_amatista/services/alert_service.dart';
import 'package:vistas_amatista/services/smartwatch_service.dart';

class AlertButtonProvider with ChangeNotifier {
  bool alertButtonEnabled = false;
  bool alertCoundownActivated = false;
  bool loading = false;

  // Remaining time values as String for countdown:
  String secondsLeft = "00";
  String minutesLeft = "00";

  void enableAlertButton() {
    alertButtonEnabled = true;
    alertCoundownActivated = false;
    notifyListeners();
  }

  void disableAlertButton() {
    alertButtonEnabled = false;
    if (alertCoundownActivated) {
      AlertService.cancelAlert();
      alertCoundownActivated = false;
    }

    notifyListeners();
  }

  Future<bool?> startAlertCountdown({int toleranceSeconds = 30}) async {
    if (!AlertService.isServiceActive) return false;
    loading = true;
    notifyListeners();
    final successful = await RestConnector.sendAlertMessage(AlertService.selectedAlert!, AlertService.selectedGroup!);
    loading = false;
    if (successful == true) {
      alertCoundownActivated = true;
      AlertService.isCountdownActive = true;
      AlertService.activateAlertCountdown(
          onEvent: showCountDown, toleranceSeconds: toleranceSeconds, onDone: stopAlertCountdown);
      notifyListeners();
      // If the smartwatch is reachable we try to send a message to it
      if (await SmartwatchService.checkIfReachable()) {
        // Sync if needed before update
        if (SmartwatchService.isSynchronized == false) {
          await SmartwatchService.sendSyncMessage();
        }
        SmartwatchService.sendAlerActivationMessage();
      }
      return true;
    } else {
      return successful;
    }
  }

  Future<bool> terminateAlertCountdown() async {
    loading = true;
    notifyListeners();
    AlertService.cancelAlert().then((value) async {
      if (value) {
        alertCoundownActivated = false;
        loading = false;
        notifyListeners();
        if (await SmartwatchService.checkIfReachable()) {
          SmartwatchService.sendAlertCancelationMessage();
        }
        return true;
      }
    });
    loading = false;
    return false;
  }

  void stopAlertCountdown() {
    AlertService.isCountdownActive = false;
    alertCoundownActivated = false;
    notifyListeners();
  }

  void showCountDown(int remainingSeconds) {
    minutesLeft = (remainingSeconds ~/ 60).toString().padLeft(2, '0');
    secondsLeft = (remainingSeconds % 60).toString().padLeft(2, '0');
    notifyListeners();
  }
}
