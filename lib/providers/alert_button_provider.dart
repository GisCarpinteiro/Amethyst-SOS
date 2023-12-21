import 'package:flutter/material.dart';
import 'package:vistas_amatista/api/rest_alert_connector.dart';
import 'package:vistas_amatista/services/alert_service.dart';

class AlertButtonProvider with ChangeNotifier {
  bool alertButtonEnabled = false;
  bool alertCoundownActivated = false;

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
      AlertService.stopActivationCountdown();
      alertCoundownActivated = false;
    }

    notifyListeners();
  }

  void startAlertCountdown({int toleranceSeconds = 30}) {
    if (!AlertService.isServiceActive) return;
    alertCoundownActivated = true;
    AlertService.isCountdownActive = true;
    RestConnector.sendAlertMessage(AlertService.selectedAlert!, AlertService.selectedGroup!);
    AlertService.startActivationCountdown(
        onEvent: showCountDown, toleranceSeconds: toleranceSeconds, onDone: stopAlertCountdown);
    notifyListeners();
  }

  void terminateAlertCountdown() {
    RestConnector.cancelAlertMessage().then((result) {
      if (result) {
        AlertService.stopActivationCountdown();
        AlertService.isCountdownActive = false;
        alertCoundownActivated = false;
        notifyListeners();
      }
    });
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
