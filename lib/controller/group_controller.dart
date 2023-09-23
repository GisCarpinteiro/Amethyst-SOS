import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vistas_amatista/controller/shared_preferences_manager.dart';
import 'package:vistas_amatista/models/group.dart';

class GroupController {
  // Restores all the data from the data base upon login
  static restoreAll() {}

  static updateGroup() {
    // TODO
  }

  static createGroup(Group newGroup) {
    // TODO
  }

  static Future<String> getGroupsAsString() async {
    // TODO: Hacer la implementación para que funcione con una consulta a firebase y no a los JSONs jaja
    return rootBundle.loadString('lib/data/groups.json');
  }

  static List<Group> getGroups() {
    SharedPreferences? sharedPreferences = SharedPrefsManager.instance;
    List<Group> groups = List.empty(growable: true);

    String? groupsAsString = sharedPreferences?.getString('groups');
    final paresedJson = jsonDecode(groupsAsString ?? "[]"); // TODO: En vez de retornar una lista vacía deberíamos de reintentar hacer la consulta y mostrar un mensaje de error.
    for (var group in paresedJson) {
      groups.add(Group.fromJson(group));
    }
    return groups;
  }

  static deleteGroup() {}

}
