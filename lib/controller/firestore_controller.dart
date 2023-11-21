import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:vistas_amatista/controller/alert_controller.dart';
import 'package:vistas_amatista/controller/group_controller.dart';
import 'package:vistas_amatista/controller/routines_controller.dart';
import 'package:vistas_amatista/controller/shared_preferences_manager.dart';
import 'package:vistas_amatista/models/alert.dart';
import 'package:vistas_amatista/models/group.dart';
import 'package:vistas_amatista/models/routine.dart';
import 'package:vistas_amatista/models/user.dart';

// This class is used to retrieve, create and delete the full document data for a certain User on firestore.
class FirestoreController {
  // This variable is really important since if it's null it means User is not logged in yet.
  static QueryDocumentSnapshot? user;
  static String? loggedUserId;

  static Future<bool> createAccount(String id, User user) async {
    FlutterLogs.logInfo("FirestoreController", "createAccount", "Trying to create account on firestore");
    // We define on thhe instance the id that the new user is going to have, in this case we do it using the same id retrieved from fireAuth when it was created
    final docUser = FirebaseFirestore.instance.collection('User').doc(id);
    Map<String, dynamic> json = user.toJson();

    json.addAll({'alerts': [], 'groups': [], 'routines': []});

    try {
      await docUser.set(json);
      FlutterLogs.logInfo("FirestoreController", "createAccount (firestore)", "SUCCESS. Account created on firestore");
      loggedUserId = id;
      return true;
    } catch (e) {
      FlutterLogs.logError("FirestoreController", "createAccount",
          "FAILURE. There was an error when trying to create the account on firestore: $e");
      return false;
    }
  }

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
      } 
      user = querySnapshot.docs[0];
      FlutterLogs.logInfo("FirestoreController", "restoreAllConfigsFromFirebase",
          "User data has been found! Logging In with data: ${user!.data()}");
      SharedPrefsManager.backupFromFirestoreToLocal(user!);
      final secureSharedPrefs = SharedPrefsManager.secureSharedInstance;
      if (secureSharedPrefs != null){
        secureSharedPrefs.putString("password", password!);
      }
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

  static Future<bool> updateRoutineList(List<Routine> newRoutineList) async {
    // Check if logged, if yes, then we proceed with the creation.
    return loggedUserId != null
        ? await RoutineController.updateRotineListOnFirebase(newRoutineList: newRoutineList, userId: loggedUserId!)
        : false;
  }

  static Future<bool> updateAlertList(List<Alert> newAlertList) async {
    // Check if logged, if yes, then we proceed with the creation.
    return loggedUserId != null
        ? await AlertController.updateAlertListOnFirebase(newAlertList: newAlertList, userId: loggedUserId!)
        : false;
  }
}
