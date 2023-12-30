import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:vistas_amatista/controller/firestore_controller.dart';
import 'package:vistas_amatista/controller/group_controller.dart';
import 'package:vistas_amatista/controller/shared_preferences_manager.dart';
import 'package:vistas_amatista/models/group.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_snackbar.dart';
import 'package:vistas_amatista/services/alert_service.dart';
import 'package:vistas_amatista/services/smartwatch_service.dart';

class GroupProvider with ChangeNotifier {
  List<Group> groups = List.empty(growable: true);
  bool isGroupEditionContext = false;
  Group group = const Group(name: "", contacts: []);
  bool isWizardContext = false;

  void getGroupsList() {
    groups = GroupController.getGroups();
  }

  // Set state to create a new Group
  void newGroupContext(BuildContext context) {
    isWizardContext = false;
    isGroupEditionContext = false;
    group = const Group(name: "Nuevo Grupo", contacts: []);
    Navigator.pushNamed(context, '/group_menu');
  }

  // Wizard context is almost the same as creation context, the only difference is that allow us to redirect to home instad of to group list.
  // Also we won't render the alert button  and navBar beffore the configuration on wizard ends
  void wizardContext(BuildContext context) {
    isWizardContext = true;
    isGroupEditionContext = false;
    group = const Group(name: "Nuevo Grupo", contacts: []);
    Navigator.pushNamed(context, '/group_menu');
  }

  // Set state to edit an already existing group
  void editGroupContext(BuildContext context, Group group) {
    isWizardContext = false;
    isGroupEditionContext = true;
    this.group = group;
    Navigator.pushNamed(context, '/group_menu');
  }

  // Update existing group or create new one depending on the creation context. This is just an auxiliary method to reutilize the view for creation and update of the groups
  void saveGroup({required String groupName, required BuildContext context}) {
    if (isGroupEditionContext) {
      // We try to update the group and send an error message if it fails to do so.
      updateGroup(Group(name: groupName, contacts: group.contacts, id: group.id)).then((response) => {
            if (response != null)
              {
                MSosFloatingMessage.showMessage(
                  context,
                  message: response,
                  type: MSosMessageType.error,
                )
              }
            else
              {Navigator.pushNamed(context, '/group_list')}
          });
    } else {
      // We try to create the group and send an error message if it fails to do so.
      createGroup(newGroupName: groupName).then((response) => {
            if (response != null)
              {
                MSosFloatingMessage.showMessage(
                  context,
                  message: response,
                  type: MSosMessageType.error,
                )
              }
            else
              {Navigator.pushNamed(context, '/group_list')}
          });
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
    group = Group(name: group.name, contacts: contactList, id: group.id);
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
    Set<int> availableIds = {1, 2, 3, 4, 5};
    for (Group existingGroup in groups) {
      if (existingGroup.name == newGroupName) return "Ya existe un grupo con ese nombre!";
      availableIds.remove(existingGroup.id);
    }
    // We build the group class and add it to the list
    groups.add(Group(id: availableIds.first, name: newGroupName, contacts: group.contacts));

    // We try to create it on firebase:
    if (await FirestoreController.updateGroupList(groups)) {
      // Then we update the shared preferences data to store it locally:
      SharedPrefsManager.updateGroupList(groups);
      AlertService.selectedGroup = null;
      if (SmartwatchService.automaticSync) {
        SmartwatchService.sendSyncMessage();
      }
      FlutterLogs.logInfo("GroupProvider", "CreateGroup", "SUCCESS: The Group Has been Created!!!");
    } else {
      FlutterLogs.logError("GroupProvider", "CreateGroup",
          "FAILURE: The group hasn't been created due to an error when trying to update the firestore data");
      return "Ah ocurrido un error al guardar el grupo de forma permanente. Revise su conexión o intente más tarde";
    }
    getGroupsList();
    notifyListeners();
    return null;
  }

  // This happens from the Group List View Only. It removes the group by clicking the delete icon on the item card.
  Future<String?> deleteGroup({required Group targetGroup}) async {
    List<Group> finalList = List.from(groups, growable: true);
    // first we try to see if it was on the list to remove it
    if (finalList.remove(targetGroup)) {
      // Then we try to remove it on firestore
      if (await FirestoreController.updateGroupList(finalList)) {
        // if removed succesfully on firestore then we delete it locally too.
        groups = finalList;
        SharedPrefsManager.updateGroupList(groups);
        AlertService.selectedGroup = null;
        if (SmartwatchService.automaticSync) {
          SmartwatchService.sendSyncMessage();
        }
        FlutterLogs.logInfo("GroupProvider", "CreateGroup", "SUCCESS: The Group Has been Deleted!!!");
        notifyListeners();
        return null;
      } else {
        FlutterLogs.logError("GroupProvider", "CreateGroup",
            "FAILURE: The group hasn't been deleted due to an error when trying to update the firestore data");
        return "Ah ocurrido un error al eliminar el grupo de forma permanente. Revise su conexión o intente más tarde";
      }
    } else {
      return "No pudimos eliminar el grupo por que no estaba en la lista";
    }
  }

  Future<String?> updateGroup(Group targetGroup) async {
    List<Group> finalList = List.from(groups, growable: true);
    // first we search for the group to update from the list and delete it to add the updated version
    bool readyToUpdate = false;
    for (Group existingGroup in finalList) {
      if (existingGroup.id == targetGroup.id) {
        finalList.remove(existingGroup);
        readyToUpdate = true;
        break;
      }
    }
    if (readyToUpdate) {
      // We add the updated version to the list and try to send it to firestore
      finalList.add(targetGroup);
      if (await FirestoreController.updateGroupList(finalList)) {
        // if updated succesfully on firestore then we update it locally to.
        groups = finalList;
        SharedPrefsManager.updateGroupList(groups);
        AlertService.selectedGroup = null;
        if (SmartwatchService.automaticSync) {
          SmartwatchService.sendSyncMessage();
        }
        FlutterLogs.logInfo("GroupProvider", "CreateGroup", "SUCCESS: The Group Has been Updated!!!");
        notifyListeners();
        return null;
      } else {
        FlutterLogs.logError("GroupProvider", "CreateGroup",
            "FAILURE: The group hasn't been updated due to an error when trying to update the firestore data");
        return "Ah ocurrido un error al actualziar el grupo de forma permanente. Revise su conexión o intente más tarde";
      }
    } else {
      return "No pudimos actualizar el grupo por que no estaba en la lista";
    }
  }
}
