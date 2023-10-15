import 'package:flutter/material.dart';
import 'package:vistas_amatista/controller/routines_controller.dart';
import 'package:vistas_amatista/models/routine.dart';

class RoutineProvider with ChangeNotifier {
  List<Routine> routines = [];
  bool isEditionContext = false;
  Routine targetRoutine = Routine(name: "", alertId: 0, groupId: 0);

  void getRoutineList() {
    routines = RoutineController.getRoutines();
  }

  void createRoutineContext(BuildContext context) {
    isEditionContext = false;
    targetRoutine = Routine(name: "", alertId: 0, groupId: 0);
    Navigator.pushNamed(context, '/routine_menu');
  }

  void editRoutineContext(BuildContext context, Routine routine) {
    isEditionContext = true;
    targetRoutine = routine;
    Navigator.pushNamed(context, '/routine_menu');
  }
}
