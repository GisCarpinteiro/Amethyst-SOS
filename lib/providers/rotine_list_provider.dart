import 'package:flutter/material.dart';
import 'package:vistas_amatista/controller/routines_controller.dart';
import 'package:vistas_amatista/models/routine.dart';

class RoutineListProvider with ChangeNotifier {
  List<Routine> routines = [];

  void getRoutineList() {
    routines = RoutineController.getRoutines();
    notifyListeners();
  }
}
