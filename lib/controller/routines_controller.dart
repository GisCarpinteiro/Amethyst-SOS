import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vistas_amatista/controller/shared_preferences_manager.dart';
import 'package:vistas_amatista/models/routine.dart';

class RoutineController {
  // Restores all the data from the data base upon login
  static restoreAll() {}

  static Future<bool> updateRotineListOnFirebase({required List<Routine> newRoutineList, required String userId}) async {
    // We need a reference for the users collection
    CollectionReference users = FirebaseFirestore.instance.collection('User');
    // Firebase only accepts maps so we need to convert the list of routines to a list of maps
    List<Map<dynamic, dynamic>> routinesListAsMaps = List.empty(growable: true);
    for (Routine routine in newRoutineList) {
      routinesListAsMaps.add(routine.toJson());
    }
    // We send the request to firebase with the list of routines as maps
    return users.doc(userId).update({'routines': routinesListAsMaps}).then((value) {
      FlutterLogs.logInfo("RoutinesController", "updateRoutinesListOnFirebase",
          "The list of routines has been updated succesfully with data: $routinesListAsMaps");
      return true;
    }).catchError((error) {
      FlutterLogs.logError("RoutinesController", "RoutinesGroupListOnFirebase",
          "Error while trying to update the list of routines on firestore with description: $error");
      return false;
    });
  }

  static Future<String> getRoutinesAsString(QueryDocumentSnapshot<Object?> user) async {
    try {
      final data = jsonEncode(user.get("routines")).toString();
      return data;
    } on StateError catch (e) {
      FlutterLogs.logWarn("RoutinesController", "getRoutinesAsString",
          "Couln't get routines from firebase with exception: ${e.message}");
    }
    return "";
  }

  static List<Routine> getRoutines() {
    SharedPreferences? sharedPreferences = SharedPrefsManager.sharedInstance;
    List<Routine> routines = List.empty(growable: true);

    String? routinesAsString = sharedPreferences?.getString('routines');
    final parsedJson = jsonDecode(routinesAsString ??
        "[]"); // TODO: En vez de retornar una lista vacía deberíamos de reintentar hacer la consulta y mostrar un mensaje de error.
    for (var routine in parsedJson) {
      routines.add(Routine.fromJson(routine));
    }
    return routines;
  }

  static deleteRoutine() {}
}
