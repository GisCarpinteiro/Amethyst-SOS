import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vistas_amatista/controller/shared_preferences_manager.dart';
import 'package:vistas_amatista/models/group.dart';

class GroupController {
  // Restores all the data from the data base upon login
  static restoreAll() {}

  static updateGroup() {
    // TODO
  }

  static Future<bool> updateGroupListOnFirebase({required List<Group> newGroupList, required String userId}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('User');
    List<Map<dynamic, dynamic>> groupListAsMaps = List.empty(growable: true);
    for (Group group in newGroupList) {
      groupListAsMaps.add(group.toJson());
    }
    return users.doc(userId).update({'groups': groupListAsMaps}).then((value) {
      FlutterLogs.logInfo("GroupController", "updateGroupListOnFirebase",
          "The list of groups has been updated succesfully with data: $groupListAsMaps");
      return true;
    }).catchError((error) {
      FlutterLogs.logError("GroupController", "updateGroupListOnFirebase",
          "Error while trying to update the list of groups on firestore with description: $error");
      return false;
    });
  }

  // This method is used to extract the groups from the firestore user data document
  static Future<String> getGroupsAsString(QueryDocumentSnapshot<Object?> user) async {
    try {
      final data = jsonEncode(user.get("groups")).toString();
      return data;
    } on StateError catch (e) {
      FlutterLogs.logWarn("GroupController", "substractGroupsAsStringFromFirestoreData",
          "Couln't get groups from firebase with exception: ${e.message}");
    }
    return "";
  }

  static List<Group> getGroups() {
    SharedPreferences? sharedPreferences = SharedPrefsManager.instance;
    List<Group> groups = List.empty(growable: true);

    // TODO: (Gisel) Si no puede obtener datos de shared preferences (no un arreglo vacío sino null) debemos de intentar restaruar shared preferences o mostrar un error
    String? groupsAsString = sharedPreferences?.getString('groups');
    final paresedJson = json.decode(groupsAsString ??
        "[]"); // TODO: En vez de retornar una lista vacía deberíamos de reintentar hacer la consulta y mostrar un mensaje de error.
    for (var group in paresedJson) {
      groups.add(Group.fromJson(group));
    }
    return groups;
  }

  static Group? getGroupById(int id) {
    List<Group> groups = getGroups();
    for (Group group in groups) {
      if (group.id == id) return group;
    }
    return null;
  }

  static deleteGroup() {}
}
