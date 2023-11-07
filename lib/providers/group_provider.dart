import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:vistas_amatista/controller/firestore_controller.dart';
import 'package:vistas_amatista/controller/group_controller.dart';
import 'package:vistas_amatista/controller/shared_preferences_manager.dart';
import 'package:vistas_amatista/models/group.dart';

class GroupProvider with ChangeNotifier {
  List<Group> groups = List.empty(growable: true);
  bool isGroupEditionContext = false;
  Group group = const Group(name: "", contacts: []);

  void getGroupsList() {
    groups = GroupController.getGroups();
  }

  // Set state to create a new Group
  void newGroupContext(BuildContext context) {
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

  // This function is called from the floating menu to add a new contact when accepting it
  bool createNewContact({required String contactName, required String phone}) {
    //Check if the name or phone of the contact is not the same as other that already exists
    for (Map existent in group.contacts) {
      if (existent["contact_name"] == contactName || existent["phone"] == phone) return false;
    }
    List<Map<String, dynamic>> contactList = List.from(group.contacts, growable: true);
    contactList.add({"contact_name": contactName, "phone": phone});
    group = Group(name: group.name, contacts: contactList);
    notifyListeners();
    return true;
  }

  // This Method is the one in charge to process and validate the data from the group menu to create a new Group on Firebase and locally
  Future<String?> createGroup({required String newGroupName}) async {
    //Check if the number of already existing groups doesn't exceeds 5 groups:
    if (groups.length >= 5) return "Solo puedes agregar 5 grupos como máximo";
    //Check if theres at least one contact assigned for that group:
    if (group.contacts.isEmpty) return "Debes de agregar al menos un contacto";
    //Check if there's not a group with the same name and also assign an id to it
    Set<int> availableIds = {1,2,3,4,5};
    for (Group existingGroup in groups){
      if (existingGroup.name == newGroupName) return "Ya existe un grupo con ese nombre!";
      availableIds.remove(existingGroup.id);
    }
    // We build the group class and add it to the list
    groups.add(Group(id: availableIds.first, name: newGroupName, contacts: group.contacts));
    
    // We try to create it on firebase:
    if(await FirestoreController.updateGroupList(groups)){
      // Then we update the shared preferences data to store it locally:
      SharedPrefsManager.updateGroupList(groups);
      FlutterLogs.logInfo("GroupProvider", "CreateGroup", "SUCCESS: The Group Has been Created!!!");
    } else{
      FlutterLogs.logError("GroupProvider", "CreateGroup", "FAILURE: The group hasn't been created due to an error when trying to update the firestore data");
      return "Ah ocurrido un error al guardar el grupo de forma permanente en nuestros servidores!";
    }
    getGroupsList();
    notifyListeners();
    return null;
  }
}
