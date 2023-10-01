import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vistas_amatista/controller/shared_preferences_manager.dart';
import 'package:vistas_amatista/models/routine.dart';

class RoutineController {
  // Restores all the data from the data base upon login
  static restoreAll() {}

  static updateRotine() {
    // TODO
  }

  static createRoutine(Routine newRoutine) {
    // TODO
  }

  static Future<String> getRoutinesAsString() async {
    // TODO: Hacer la implementación para que funcione con una consulta a firebase y no a los JSONs jaja
    return rootBundle.loadString('lib/data/routines.json');
  }

  static List<Routine> getRoutines() {
    SharedPreferences? sharedPreferences = SharedPrefsManager.instance;
    List<Routine> routines = List.empty(growable: true);

    String? routinesAsString = sharedPreferences?.getString('routines');
    FlutterLogs.logInfo("RoutineController", "getRoutines", 'the routines from obtained from shared preferences are: $routinesAsString');
    final parsedJson = jsonDecode(routinesAsString ??
        "[]"); // TODO: En vez de retornar una lista vacía deberíamos de reintentar hacer la consulta y mostrar un mensaje de error.
    for (var routine in parsedJson) {
      routines.add(Routine.fromJson(routine));
    }
    return routines;
  }

  static deleteRoutine() {}
}
