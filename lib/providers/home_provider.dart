import 'package:flutter/material.dart';
import 'package:vistas_amatista/controller/alert_controller.dart';
import 'package:vistas_amatista/controller/group_controller.dart';
import 'package:vistas_amatista/models/alert.dart';
import 'package:vistas_amatista/models/group.dart';
import 'package:vistas_amatista/services/alert_services/alert_manager.dart';

class HomeProvider with ChangeNotifier {
  bool isServiceEnabled =
      false; // Status needed to change the color an behavior of some widgets/elements on homescreen.
  int selectedAlert = 0; // Name of the actual alert picked by the multi option widget
  int selectedGroup = 0; // Name of the actual group picked on the multi option widget
  AlertState alertState = AlertState.disabled; // State of the alert (active, inactive, waiting, disable)
  List<Alert> alerts = [];
  List<Group> groups = [];

  void toggleServiceEnabled() {
    //TODO: Llamar a alert service para que inicialice con el servicio de las alertas!
    isServiceEnabled = !isServiceEnabled;
    AlertManager.selectedGroup = groups[selectedGroup];
    AlertManager.selectedAlert = alerts[selectedAlert];
    notifyListeners();
  }

  void selectAlert(int alertIndex) {
    selectedAlert = alertIndex;
    AlertManager.selectedAlert = alerts[selectedAlert];
    notifyListeners();
  }

  void selectGroup(int groupIndex) {
    selectedGroup = groupIndex;
    AlertManager.selectedGroup = groups[selectedGroup];
    notifyListeners();
  }

  void getAlertAndGroupList() {
    alerts = AlertController.getAlerts();
    groups = GroupController.getGroups();
  }
  
}
