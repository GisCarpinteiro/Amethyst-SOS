import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:vistas_amatista/controller/alert_controller.dart';
import 'package:vistas_amatista/controller/group_controller.dart';
import 'package:vistas_amatista/models/alert.dart';
import 'package:vistas_amatista/models/group.dart';
import 'package:vistas_amatista/providers/alert_button_provider.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_snackbar.dart';
import 'package:vistas_amatista/services/alert_service.dart';
import 'package:vistas_amatista/services/smartwatch_service.dart';
import 'package:vistas_amatista/services/disconnection_service.dart';

class HomeProvider with ChangeNotifier {
  bool isServiceEnabled =
      false; // Status needed to change the color an behavior of some widgets/elements on homescreen.
  Alert? selectedAlert = AlertService.selectedAlert; // Name of the actual alert picked by the multi option widget
  Group? selectedGroup = AlertService.selectedGroup; // Name of the actual group picked on the multi option widget
  AlertState alertState = AlertState.disabled; // State of the alert (active, inactive, waiting, disable)
  List<Alert> alerts = [];
  List<Group> groups = [];
  bool pendingAlertMessages = false;

  void toggleServiceEnabled() {
    //TODO: Llamar a alert service para que inicialice con el servicio de las alertas!
    isServiceEnabled = !isServiceEnabled;
    AlertService.selectedGroup = selectedGroup;
    AlertService.selectedAlert = selectedAlert;
    notifyListeners();
  }

  void startServiceFromWatch() {
    selectedAlert = AlertService.selectedAlert;
    selectedGroup = AlertService.selectedGroup;
    isServiceEnabled = true;
    alertState = AlertState.inactive;
    notifyListeners();
  }

  void stopServiceFromWatch() {
    isServiceEnabled = false;
    alertState = AlertState.disabled;
    notifyListeners();
  }

  Future<String?> startAlertService(BuildContext context) async {
    final buttonProvider = context.read<AlertButtonProvider>();
    FlutterLogs.logInfo("HomeProvider", "StartAlertService", "Starting Alert Service...");
    // First we verify an alert and group has been selected
    if (selectedAlert == null) return "No se ha seleccionado una alerta!";
    if (selectedGroup == null) return "No se ha seleccionado un grupo";
    AlertService.selectedAlert = selectedAlert;
    AlertService.selectedGroup = selectedGroup;
    AlertService.initServiceManually().then((errorMessage) {
      // We process if there was an error
      if (errorMessage != null) return errorMessage;
      buttonProvider.enableAlertButton();
      // Then we validate the service has been initialized
      if (!AlertService.isServiceActive) return "No se ha podido iniciar el servicio";
      isServiceEnabled = true;
      if (SmartwatchService.isReachable && SmartwatchService.isSynchronized) {
        FlutterLogs.logInfo("Home", "StartSmartwatchAlertService", "SMARTWATCH: Trying to start service on smartwatch");
        SmartwatchService.sendStartServiceMessage().then((value) {
          if (value != null) {
            FlutterLogs.logError("Home", "StartSmartwatchAlertService",
                "SMARTWATCH: The following error occurred when trying to init service on smartwatch: $value");
            MSosFloatingMessage.showMessage(context, message: value, type: MSosMessageType.alert);
          } else {
            FlutterLogs.logInfo(
                "Home", "StartSmartwatchAlertService", "SMARTWATCH: The service has started on smartwatch too");
          }
        });
      }
      notifyListeners();
    });
    // If the smartwatch is reachable and syncronized, we try to send a message to it
    await DisconnectionService.startDisconnectionService();
    return null;
  }

  Future<String?> stopAlertService(BuildContext context) async {
    AlertService.stopService().then((errorMessage) {
      if (errorMessage != null) return errorMessage;
      context.read<AlertButtonProvider>().disableAlertButton();
      isServiceEnabled = false;
      notifyListeners();
    });
    return null;
  }

  void selectAlert(Alert alert) {
    selectedAlert = alert;
    AlertService.selectedAlert = selectedAlert;
    notifyListeners();
  }

  void selectGroup(Group group) {
    selectedGroup = group;
    AlertService.selectedGroup = selectedGroup;
    notifyListeners();
  }

  void getAlertAndGroupList() {
    alerts = AlertController.getAlerts();
    groups = GroupController.getGroups();
    AlertService.selectedAlert = AlertService.selectedAlert ?? (alerts.isEmpty ? null : alerts[0]);
    AlertService.selectedGroup = AlertService.selectedGroup ?? (alerts.isEmpty ? null : groups[0]);
    selectedAlert = AlertService.selectedAlert;
    selectedGroup = AlertService.selectedGroup;
  }
}
