import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
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

  static deleteGroup() {}

  static List<Group> getGroupsFromLocal() {
    List<Group> groups = List.empty(growable: true);

    rootBundle.loadString('lib/data/groups.json').then((input) {
      final paresedJson = jsonDecode(input);
      for (var group in paresedJson) {
        groups.add(Group.fromJson(group));
      }

      return groups;
    });

    return groups;
  }
}
