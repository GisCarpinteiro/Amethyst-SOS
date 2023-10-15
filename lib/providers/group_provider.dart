import 'package:flutter/material.dart';
import 'package:vistas_amatista/controller/group_controller.dart';
import 'package:vistas_amatista/models/group.dart';

class GroupProvider with ChangeNotifier {
  List<Group> groups = [];
  bool isGroupEditionContext = false;
  Group group = const Group(name: "", contacts: []);

  void getGroupsList() {
    groups = GroupController.getGroups();
  }

  // Set state to create a new Group
  void createGroupContext(BuildContext context) {
    isGroupEditionContext = false;
    group = const Group(name: "Nuevo Grupo", contacts: []);
    Navigator.pushNamed(context, '/group_menu');
  }

  // Set state to edit an already existing group
  void editGroupContext(BuildContext context, Group group) {
    isGroupEditionContext = true;
    this.group = group;
    Navigator.pushNamed(context, '/group_menu');
  }

  // Update existing group or create new one
  void saveGroup() {
    if (isGroupEditionContext) {
      // TODO: Update Group
    } else {
      // TODO: Create new Group
    }
  }
}
