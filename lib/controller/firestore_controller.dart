import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:vistas_amatista/controller/group_controller.dart';
import 'package:vistas_amatista/controller/shared_preferences_manager.dart';
import 'package:vistas_amatista/models/group.dart';

// This class is used to retrieve, create and delete the full document data for a certain User on firestore.
class FirestoreController {
  // This variable is really important since if it's null it means User is not logged in yet.
  static QueryDocumentSnapshot? user;
  static String? loggedUserId;

  static Future<bool> getUserData(String? email, String? password) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FlutterLogs.logInfo(
        "FirestoreController", "restoreAllConfigsFromFirebase", "Retrieving Data for User with email: $email");
    return await firestore
        .collection('User')
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isEmpty) {
        FlutterLogs.logWarn(
            "FirestoreController", "restoreAllConfigsFromFirebase", "Not USERS where found with that email");
        return false;
      } else if (querySnapshot.docs.length > 1) {
        FlutterLogs.logWarn("FirestoreController", "restoreAllConfigsFromFirebase",
            "There are two ore more users with the same Email! only one of them will be used");
      } else {}
      user = querySnapshot.docs[0];
      FlutterLogs.logInfo("FirestoreController", "restoreAllConfigsFromFirebase",
          "User data has been found! Logging In with data: ${user!.data()}");
      SharedPrefsManager.backupFromFirestoreToLocal(user!);
      loggedUserId = user!.id;
      return true;
    });
  }

  static Future<bool> updateGroupList(List<Group> newGroupList) async {
    // Check if logged, if yes, then we proceed with the creation.
    return loggedUserId != null
        ? await GroupController.updateGroupListOnFirebase(newGroupList: newGroupList, userId: loggedUserId!)
        : false;
  }

}
