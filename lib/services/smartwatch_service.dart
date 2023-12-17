import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:vistas_amatista/models/alert.dart';
import 'package:vistas_amatista/models/group.dart';
import 'package:vistas_amatista/providers/alert_button_provider.dart';
import 'package:vistas_amatista/controller/shared_preferences_manager.dart';
import 'package:vistas_amatista/providers/home_provider.dart';
import 'package:vistas_amatista/services/alert_services/alert_service.dart';
import 'package:watch_connectivity/watch_connectivity.dart';

class SmartwatchService with ChangeNotifier {
  static HomeProvider? homeProvider;
  static AlertButtonProvider? bottomBarProvider;
  static final sharedPrefsInstance = SharedPrefsManager.sharedInstance;
  static final watchConnection = WatchConnectivity();
  static bool isSynchronized = false;
  static bool isReachable = false;
  static int toleranceTimeInSeconds = 120;
  static bool automaticSync = true;
  static StreamSubscription<Map<String, dynamic>>? _subscription;

  // * ------------------------ >>> GENERAL METHODS <<< ----------------------------------- * //

  // Listen until stopped or define a number of times to listen to events (receive a message from the smartwatch)
  static void startListening2Watch({int? times}) {
    _subscription?.cancel();
    // If the service is active, we must receive unlimited messages, if not, only the defined times
    if (times != null) watchConnection.messageStream.take(times);
    _subscription = watchConnection.messageStream.listen((message) => processMessageFromWatch(message));
  }

  static void stopListening2Watch() {
    _subscription?.pause();
  }

  static Future<bool> checkIfReachable() async {
    isReachable = await watchConnection.isReachable;
    return isReachable;
  }

  // * --------------------------- >>> DATA TRANSMISION ERRORS <<< ----------------------- * //

  //* A sync message needs to be sended to update the info that the watch has regarding groups, alerts, status of the service and other variables.
  //* This sync could be triggered mannualy, or automatically while the service is reachable
  static Future<String?> sendSyncMessage() async {
    final Map<String, dynamic> syncMessage = {
      "type": "SYNC",
      "alerts": sharedPrefsInstance?.get("alerts"),
      "groups": sharedPrefsInstance?.get("groups"),
      "toleranceDisconnectionTime": toleranceTimeInSeconds
    };
    final errorMessage = await send(syncMessage);
    if (errorMessage != null) {
      isSynchronized = false;
      return errorMessage;
    } else {
      isSynchronized = true;
      return null;
    }
  }

  static Future<String?> sendStartServiceMessage() async {
    FlutterLogs.logInfo("SmartwatchService", "sendStartServiceMessage", "Sending start service message to smartwatch");
    final Map<String, dynamic> message = {
      "type": "START",
      "alert": jsonEncode(AlertService.selectedAlert!.toJson()),
      "group": jsonEncode(AlertService.selectedGroup!.toJson()),
      "toleranceDisconnectionTime": toleranceTimeInSeconds
    };
    return await send(message);
  }

  static Future<String?> sendStopServiceMessage() async {
    FlutterLogs.logInfo("SmartwatchService", "sendStopServiceMessage", "Sending stop service message to smartwatch");
    final Map<String, dynamic> message = {"type": "STOP"};
    return await send(message);
  }

  static Future<String?> send(Map<String, dynamic> data) async {
    startListening2Watch();
    if (await checkIfReachable()) {
      try {
        final startTime = DateTime.now();
        await watchConnection.sendMessage(data);
        // We need to wait for a response from the watch to know that the sync message has been received
        Map<String, dynamic> response = {};
        // We reasign the callback function that the stream does when data has been received
        _subscription?.onData((data) {
          response = data;
          FlutterLogs.logInfo(
              "SmartwatchService", "send -> StreamSubscription.onData()", "Response from smartwatch: $response");
        });

        while (DateTime.now().difference(startTime) < const Duration(milliseconds: 2000)) {
          await Future.delayed(const Duration(milliseconds: 100));
          if (response.isNotEmpty) {
            startListening2Watch();
            return null;
          }
        }
        startListening2Watch();
        return "Tiempo de espera ha sido excedido";
      } catch (e) {
        startListening2Watch();
        return "Error";
      }
    } else {
      return "Error";
    }
  }

  // * --------------------- >>> DATA RECEPTION METHODS <<< --------------------------------- * //
  static Future<bool> processMessageFromWatch(Map<String, dynamic> data) async {
    FlutterLogs.logInfo("SmartWatchService", "ProcessMessageFromWatch", "Message received with data: $data");
    switch (data['type']) {
      case 'START':
        await processStartServiceMessage(data);
        break;
      case 'STOP':
        await processStopServiceMessage(data);
        break;
      case 'ACTIVATE':
        break;
      case 'CANCEL':
      default:
    }

    return true;
  }

  static Future<bool> processStartServiceMessage(Map<String, dynamic> data) async {
    FlutterLogs.logInfo(
        "SmartwatchService", "ProccessStartServiceMessage", "Trying to START service from smartwatch...");

    AlertService.selectedAlert = Alert.fromJson(json.decode(data['alert']));
    AlertService.selectedGroup = Group.fromJson(json.decode(data['group']));
    final serviceResponse = await AlertService.initServiceManually();
    if (serviceResponse == null) {
      if (homeProvider != null && bottomBarProvider != null) {
        homeProvider!.startServiceFromWatch();
        bottomBarProvider!.enableAlertButton();
        await watchConnection.sendMessage({"response": "SUCCESS"});
        return true;
      }
    }
    await watchConnection.sendMessage({"response": "FAILURE"});
    return false;
  }

  static Future<bool> processStopServiceMessage(Map<String, dynamic> data) async {
    FlutterLogs.logInfo(
        "SmartwatchService", "ProccessStartServiceMessage", "Trying to STOP service from smartwatch...");

    if (await AlertService.stopService() == null) {
      if (homeProvider != null && bottomBarProvider != null) {
        homeProvider!.stopServiceFromWatch();
        bottomBarProvider!.disableAlertButton();
        await watchConnection.sendMessage({"response": "SUCCESS"});
        return true;
      }
    }
    await watchConnection.sendMessage({"response": "FAILURE"});
    return false;
  }
}
