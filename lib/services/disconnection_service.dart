import 'dart:async';

import 'package:flutter_logs/flutter_logs.dart';
import 'package:vistas_amatista/api/rest_alert_connector.dart';
import 'package:vistas_amatista/controller/shared_preferences_manager.dart';
import 'package:vistas_amatista/models/alert.dart';
import 'package:vistas_amatista/services/alert_service.dart';
import 'package:vistas_amatista/services/location_service.dart';

class DisconnectionService {
  static int toleranceMinutes = 5;
  static bool isServiceEnabled = true;
  // The warning state happends when a location update fails to be sended to server.
  static bool warningState = false;

  static StreamSubscription<bool>? updateLocationSubscription;

  // This method returns true if the service has been initiated succesfully
  static Future<bool> startDisconnectionService() async {
    // First wee need to decide wether if it's necessary to start the service or not based on alert trigger configs
    if (AlertService.selectedAlert?.triggers['disconnection_trigger'] == false || isServiceEnabled == false) {
      return false;
    }

    // Then we make a POST into the disconnection service endpoint
    final String? userId = SharedPrefsManager.sharedInstance?.getString('id');
    final String? location = await LocationService.getCurrentLocation();

    if (userId == null || location == null) return false;

    FlutterLogs.logInfo(
        "DisconnectionService", "startDisconnectionService", "Trying to initiate the disconnection service...");

    final Map<String, dynamic> requestBody = {
      "userId": userId,
      "alertMessage": AlertService.selectedAlert!.message,
      "contacts": AlertService.selectedGroup!.contacts.map((contact) {
        return contact['phone'];
      }).toList(),
      "location": location,
      "toleranceMinutes": toleranceMinutes
    };

    if (!await RestConnector.postDisconnectionService(requestBody)) {
      FlutterLogs.logInfo(
          "DisconnectionService", "startDisconnectionService", "FAILURE: Disconnection Service failed to start.");
      return false;
    }

    // If the service was correctly initiated then we start the stram in charge to update the location periodically
    updateLocationSubscription?.cancel();

    updateLocationSubscription =
        Stream<bool>.periodic(Duration(seconds: toleranceMinutes), (value) => true).listen((event) {
      updateLocation().then((value) {
        if (!value) {
          if (!warningState) {
            AlertService.activeMessages.add(AlertService.UPDATE_LOCATION_FAILURE);
            warningState = true;
          } else {
            AlertService.activeMessages.remove(AlertService.UPDATE_LOCATION_FAILURE);
            AlertService.activeMessages.add(AlertService.DISCONNECTION_SERVICE_ALERTED);
            stopDisconnectionService();
            warningState = false;
          }
        } else {
          if (warningState) {
            AlertService.activeMessages.remove(AlertService.UPDATE_LOCATION_FAILURE);
            warningState = false;
          }
        }
      });
    });

    return true;
  }

  static Future<bool> stopDisconnectionService() async {
    if (AlertService.selectedAlert?.triggers['disconnection_trigger'] == false || isServiceEnabled == false) {
      return false;
    }
    final String? userId = SharedPrefsManager.sharedInstance!.getString("id");
    if (userId == null) return false;
    RestConnector.terminateDisconnectionService(userId).then((successful) {
      if (!successful) return false;
      updateLocationSubscription?.cancel();
      FlutterLogs.logInfo("DisconnectionService", "stopDisconnectionService",
          "TERMINATED: Disconnection service has been succesfully stoped");
      return true;
    });
    return false;
  }

  static Future<bool> updateLocation() async {
    // Here we try to update the location to server for disconnection service. this is executed periodically
    final String? userId = SharedPrefsManager.sharedInstance?.getString('id');
    final String? location = await LocationService.getCurrentLocation();
    if (userId == null || location == null) return false;

    FlutterLogs.logInfo("DisconnectionService", "startDisconnectionService", "Updating location to server");
    if (await RestConnector.updateDisconnectionServiceLocation(userId, location)) {
      FlutterLogs.logInfo(
          "DisconnectionService", "updateLocation", "SUCCESS: Location updated for disconnection service");
      return true;
    } else {
      FlutterLogs.logInfo(
          "DisconnectionService", "updateLocation", "FAILURE: The location wasn't updated, entering warning state!");
    }
    return false;
  }
}
