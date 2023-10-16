import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vistas_amatista/controller/alert_controller.dart';
import 'package:vistas_amatista/controller/group_controller.dart';
import 'package:vistas_amatista/controller/routines_controller.dart';
import 'package:vistas_amatista/models/alert.dart';
import 'package:vistas_amatista/models/group.dart';
import 'package:vistas_amatista/models/routine.dart';

class RoutineProvider with ChangeNotifier {
  List<Routine> routines = [];
  bool isEditionContext = false;
  Routine targetRoutine = Routine(name: "", alertId: 0, groupId: 0);
  Alert? selectedAlert;
  Group? selectedGroup;
  List<Alert> alerts = [];
  List<Group> groups = [];
  static const dayNames = ['lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado', 'domingo'];
  final List<Widget> days = dayNames
      .map((name) => Text(name,
          style: GoogleFonts.lexend(
              textStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ))))
      .toList();
  List<bool> selectedDays = <bool>[false, false, false, false, false, false, false];
  Map<String, int> selectedTime = {'hour': 0, 'min': 0};

  void getRoutineList() {
    routines = RoutineController.getRoutines();
  }

  void createRoutineContext(BuildContext context) {
    alerts = AlertController.getAlerts();
    groups = GroupController.getGroups();
    selectedAlert = null;
    selectedGroup = null;
    isEditionContext = false;
    targetRoutine = Routine(name: "", alertId: 0, groupId: 0);
    selectedDays = [false, false, false, false, false, false, false];
    selectedTime = {'hour': 0, 'min': 0};
    Navigator.pushNamed(context, '/routine_menu');
  }

  void editRoutineContext(BuildContext context, Routine routine) {
    alerts = AlertController.getAlerts();
    groups = GroupController.getGroups();
    isEditionContext = true;
    targetRoutine = routine;
    selectedAlert = AlertController.getAlertById(routine.alertId);
    selectedGroup = GroupController.getGroupById(routine.groupId);
    selectedDays = [];
    targetRoutine.days.forEach((key, value) => selectedDays.add(value));
    selectedTime = {'hour': routine.startTime['hour'], 'min': routine.startTime['min']};
    Navigator.pushNamed(context, '/routine_menu');
  }

  void selectAlert(Alert alert) {
    selectedAlert = alert;
    // ! We need to update AlertManager of the selected alert upon activation so we need to save the value.
    notifyListeners();
  }

  void selectGroup(Group group) {
    selectedGroup = group;
    // ! We need to update AlertManager of the selected alert upon activation so we need to save the value.
    notifyListeners();
  }
}
