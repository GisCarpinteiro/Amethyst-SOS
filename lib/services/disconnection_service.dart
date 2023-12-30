import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:vistas_amatista/api/rest_alert_connector.dart';
import 'package:vistas_amatista/controller/shared_preferences_manager.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_snackbar.dart';
import 'package:vistas_amatista/services/alert_service.dart';
import 'package:vistas_amatista/services/location_service.dart';

class DisconnectionService {
  static int toleranceMinutes = 5;
  static bool isServiceEnabled = false;
  // The warning state happends when a location update fails to be sended to server.
  static bool warningState = false;
  static bool isActive = false;
  static BuildContext? globalContext;

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
    await updateLocationSubscription?.cancel();

    updateLocationSubscription =
        Stream<bool>.periodic(Duration(seconds: toleranceMinutes), (value) => true).listen((event) async {
      final isUpdated = await updateLocation();

      if (!isUpdated) {
        if (warningState) {
          warningState = false;
          MSosFloatingMessage.showMessage(globalContext!,
              type: MSosMessageType.error,
              title: "Servicio de Desconexión:",
              message:
                  "La actualización de ubicación falló dos veces consecutivas. Las alertas serán enviadas por el servidor");
          await updateLocationSubscription?.cancel();
        } else {
          warningState = true;
          MSosFloatingMessage.showMessage(globalContext!,
              type: MSosMessageType.error,
              title: "Servicio de Desconexión:",
              message: "No se actualizó la última actualización! podría causar envió de alerta involuntario");
        }
      }
    });
    return true;
  }

  static Future<bool> stopDisconnectionService() async {
    if (AlertService.selectedAlert?.triggers['disconnection_trigger'] == false || isServiceEnabled == false) {
      return false;
    }
    final String? userId = SharedPrefsManager.sharedInstance!.getString("id");
    if (userId == null) return false;
    if (!await RestConnector.terminateDisconnectionService(userId)) return false;
    await updateLocationSubscription?.cancel();
    FlutterLogs.logInfo("DisconnectionService", "stopDisconnectionService",
        "TERMINATED: Disconnection service has been succesfully stoped");
    return true;
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
