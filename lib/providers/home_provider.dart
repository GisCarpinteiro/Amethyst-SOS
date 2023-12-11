import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:vistas_amatista/controller/alert_controller.dart';
import 'package:vistas_amatista/controller/group_controller.dart';
import 'package:vistas_amatista/models/alert.dart';
import 'package:vistas_amatista/models/group.dart';
import 'package:vistas_amatista/providers/bottombar_provider.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_snackbar.dart';
import 'package:vistas_amatista/services/alert_services/alert_manager.dart';
import 'package:vistas_amatista/services/smartwatch_service.dart';

class HomeProvider with ChangeNotifier {
  bool isServiceEnabled =
      false; // Status needed to change the color an behavior of some widgets/elements on homescreen.
  Alert? selectedAlert = AlertService.selectedAlert; // Name of the actual alert picked by the multi option widget
  Group? selectedGroup = AlertService.selectedGroup; // Name of the actual group picked on the multi option widget
  AlertState alertState = AlertState.disabled; // State of the alert (active, inactive, waiting, disable)
  List<Alert> alerts = [];
  List<Group> groups = [];

  void toggleServiceEnabled() {
    //TODO: Llamar a alert service para que inicialice con el servicio de las alertas!
    isServiceEnabled = !isServiceEnabled;
    AlertService.selectedGroup = selectedGroup;
    AlertService.selectedAlert = selectedAlert;
    notifyListeners();
  }


  void startServiceStateFromWatch() {
    selectedAlert = AlertService.selectedAlert;
    selectedGroup = AlertService.selectedGroup;
    isServiceEnabled = true;
    alertState = AlertState.inactive;
    notifyListeners();
  }

  Future<bool> startAlertService(BuildContext context) async {
    FlutterLogs.logInfo("ButtomBar", "Start Service Button Callback", "Starting Alert Service...");
    // TODO: Iniciar el servicio de alertas!!!!
    toggleServiceEnabled();
    if (isServiceEnabled) {
      AlertService.initServiceManually().then((value) {
        context.read<BottomBarProvider>().enableAlertButton();
        if (AlertService.isServiceActive) {
          MSosFloatingMessage.showMessage(
            context,
            title: "Servicio Activado",
            message: 'Alerta "${selectedAlert!.name}" habilitada',
            type: MSosMessageType.info,
          );
          if (SmartwatchService.isReachable) {
            FlutterLogs.logInfo(
                "Home", "StartSmartwatchAlertService", "SMARTWATCH: Trying to start service on smartwatch");
            SmartwatchService.sendStartServiceMessage().then((value) {
              if (value != null) {
                FlutterLogs.logError("Home", "StartSmartwatchAlertService",
                    "SMARTWATCH: The following error occurred when trying to init service on smartwatch: $value");
                MSosFloatingMessage.showMessage(context, message: "value", type: MSosMessageType.alert);
              } else {
                FlutterLogs.logInfo(
                    "Home", "StartSmartwatchAlertService", "SMARTWATCH: The service has started on smartwatch too");
              }
            });
          }
          return true;
        } else {
          toggleServiceEnabled();
          AlertService.stopService();
          MSosFloatingMessage.showMessage(
            context,
            title: "Algo ha fallado!",
            message: 'No se ha podido iniciar el servicio',
            type: MSosMessageType.alert,
          );
          return false;
        }
      });
    } else {
      AlertService.stopService();
      context.read<BottomBarProvider>().disableAlertButton();
      MSosFloatingMessage.showMessage(
        context,
        title: "Servicio Desactivado",
        message: 'Alerta "${selectedAlert!.name}" deshabilitada',
      );
      return false;
    }
    return false;
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
    selectedAlert = AlertService.selectedAlert;
    selectedGroup = AlertService.selectedGroup;
  }
}
