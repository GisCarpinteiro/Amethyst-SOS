
import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vistas_amatista/controller/alert_controller.dart';
import 'package:vistas_amatista/controller/firestore_controller.dart';
import 'package:vistas_amatista/controller/group_controller.dart';
import 'package:vistas_amatista/controller/routines_controller.dart';
import 'package:vistas_amatista/controller/shared_preferences_manager.dart';
import 'package:vistas_amatista/models/alert.dart';
import 'package:vistas_amatista/models/group.dart';
import 'package:vistas_amatista/models/routine.dart';

class RoutineProvider with ChangeNotifier {
  List<Routine> routines = [];
  int routineId = 0;
  String routineName = "";
  bool isEditionContext = false;
  Alert? selectedAlert;
  Group? selectedGroup;
  List<Alert> alerts = [];
  List<Group> groups = [];
  static const dayNames = ['L', 'M', 'M', 'J', 'V', 'S', 'D'];
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
  int durationMinutes = 30;

  void getRoutineList() {
    routines = RoutineController.getRoutines();
  }

  void createRoutineContext(BuildContext context) {
    alerts = AlertController.getAlerts();
    groups = GroupController.getGroups();
    routineName = "";
    selectedAlert = null;
    selectedGroup = null;
    isEditionContext = false;
    selectedDays = [false, false, false, false, false, false, false];
    selectedTime = {'hour': 0, 'min': 0};
    Navigator.pushNamed(context, '/routine_menu');
  }

  void editRoutineContext(BuildContext context, Routine routine) {
    routineId = routine.id!;
    alerts = AlertController.getAlerts();
    groups = GroupController.getGroups();
    isEditionContext = true;
    routineName = routine.name;
    selectedAlert = AlertController.getAlertById(routine.alertId);
    selectedGroup = GroupController.getGroupById(routine.groupId);
    selectedDays = [];
    routine.days.forEach((key, value) => selectedDays.add(value));
    selectedTime = {'hour': routine.startTime['hour'], 'min': routine.startTime['min']};
    Navigator.pushNamed(context, '/routine_menu');
  }

  void selectAlert(Alert alert) {
    selectedAlert = alert;
    // ! We need to update AlertManager of the selected alert upon activation so we need to save the value.
    notifyListeners();
  }

  void refreshView() {
    notifyListeners();
  }

  void selectGroup(Group group) {
    selectedGroup = group;
    // ! We need to update AlertManager of the selected alert upon activation so we need to save the value.
    notifyListeners();
  }

  void updateStartTime(Map<String, int> startTime) {
    selectedTime = startTime;
  }

  // This method allow us to update or create a routine.
  Future<String?> saveRoutine({required String newRoutineName}) async {
    // Check everything has been selected and all pre requesites are there:

    // First we have to check if the number of configured routines is the maximum. (only for creation)
    if (!isEditionContext) if (routines.length >= 3) return "Solo puedes agregar 3 rutinas como máximo";
    // Then check the name is not defined
    if (newRoutineName == "") return "La rutina debe tener un nombre";
    // Verify that an alert and a group have been selected
    if (selectedAlert == null) return "Debe elegirse una alerta!";
    if (selectedGroup == null) return "Debe elegirse un grupo!";
    final alerts = AlertController.getAlerts();
    final groups = GroupController.getGroups();

    // We start by checking the selected alert exists
    bool alertAndGroupExist = false;
    for (Alert alert in alerts) {
      if (alert.id == selectedAlert!.id) {
        selectedAlert = alert;
        alertAndGroupExist = true;
        break;
      }
    }
    if (!alertAndGroupExist) return "La alerta seleccionada no existe! Aseguresé de elegir una existente";
    // Then we do the same but this time for the selected group
    alertAndGroupExist = false;
    for (Group group in groups) {
      if (group.id == selectedGroup!.id) {
        selectedGroup = group;
        alertAndGroupExist = true;
        break;
      }
    }
    if (!alertAndGroupExist) return "El grupo seleccionado no existe! Aseguresé de elegir un existente";

    List<Routine> routinesCopy = List.from(routines, growable: true);
    Set<int> avaliableIds = {0, 1, 2};
    // If it's an update first we need to delete the old version of the routine
    if (isEditionContext) {
      for (Routine existingRoutine in routinesCopy) {
        if (existingRoutine.id == routineId) {
          routinesCopy.remove(existingRoutine);
          break;
        }
      }
    }
    // Check if there wasn't another routine with the same name
    for (Routine existingRoutine in routinesCopy) {
      if (existingRoutine.name == newRoutineName) return "Ya existe una rutina con ese nombre";
      if (!isEditionContext) avaliableIds.remove(existingRoutine.id);
    }

    // We build the new routine to be added

    routinesCopy.add(Routine(
        id: isEditionContext ? routineId : avaliableIds.first,
        name: newRoutineName,
        alertId: selectedAlert!.id!,
        groupId: selectedGroup!.id!,
        days: {
          "monday": selectedDays[0],
          "tuesday": selectedDays[1],
          "wednesday": selectedDays[2],
          "thursday": selectedDays[3],
          "friday": selectedDays[4],
          "saturday": selectedDays[5],
          "sunday": selectedDays[6],
        },
        startTime: selectedTime,
        durationMinutes: durationMinutes));
    // We try to update the routine list on firestore
    if (await FirestoreController.updateRoutineList(routinesCopy)) {
      // If succesfull then we update shared preferences data locally:
      SharedPrefsManager.updateRoutineList(routinesCopy);
      isEditionContext
          ? FlutterLogs.logInfo("RoutineProvider", "saveRoutine", "SUCCESS the routine has been updated!!!")
          : FlutterLogs.logInfo("RoutineProvider", "saveRoutine", "SUCCESS the routine has been created!!!");
      notifyListeners();
      return null;
    } else {
      FlutterLogs.logError("RoutineProvider", "SaveRoutine",
          "FAILURE: The routine hasn't been created/updated due to an error when trying to update the firestore data");
      return isEditionContext
          ? "Ah ocurrido un error al actualizar la rutina de forma permanente. Revise su conexión a internet o intente más tarde"
          : "Ah ocurrido un error al crear la rutina de forma permanente. Revise su conexión a internet o intente más tarde";
    }
  }

  Future<String?> deleteRoutine(Routine targetRoutine) async {
    List<Routine> listCopy = List.from(routines, growable: true);
    // We try to remove it from the list
    if (listCopy.remove(targetRoutine)) {
      // If we succeed doing it then we try to remove it on firestore
      if (await FirestoreController.updateRoutineList(listCopy)) {
        routines = listCopy;
        SharedPrefsManager.updateRoutineList(routines);
        FlutterLogs.logInfo("RoutineProvider", "deleteRoutine", "SUCCESS the group has been deleted!!!");
        notifyListeners();
        return null;
      } else {
        FlutterLogs.logError("RoutineProvider", "deleteRoutine",
            "FAILURE: The routine hasn't been deleted due to an error when trying to update the firestore data");
        return "Ah ocurrido un error al eliminar la rutina de forma permanente. Revise su conexión a internet o intente más tarde";
      }
    } else {
      return "No pudimos eliminar la rutina por que no estaba en la lista";
    }
  }
}
