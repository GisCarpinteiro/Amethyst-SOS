import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:vistas_amatista/models/alert.dart';
import 'package:vistas_amatista/models/group.dart';
import 'package:vistas_amatista/providers/bottombar_provider.dart';
import 'package:vistas_amatista/controller/shared_preferences_manager.dart';
import 'package:vistas_amatista/providers/home_provider.dart';
import 'package:vistas_amatista/services/alert_services/alert_manager.dart';
import 'package:watch_connectivity/watch_connectivity.dart';

class SmartwatchService with ChangeNotifier {
  static HomeProvider? homeProvider;
  static BottomBarProvider? bottomBarProvider;
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
    if (times != null && !AlertService.isServiceActive) watchConnection.messageStream.take(times);
    _subscription = watchConnection.messageStream.listen((message) => processMessageFromWatch(message));
  }

  static void stopListening2Watch() {
    _subscription?.pause();
  }

  static Future<bool> checkIfReachable() async {
    isReachable = await watchConnection.isReachable;
    return isReachable;
  }

  //* A sync message needs to be sended to update the info that the watch has regarding groups, alerts, status of the service and other variables.
  //* This sync could be triggered mannualy, or automatically while the service is reachable
  static Future<String?> sendSyncMessage() async {
    final Map<String, dynamic> syncMessage = {
      "type": "SYNC",
      "alerts": sharedPrefsInstance?.get("alerts"),
      "groups": sharedPrefsInstance?.get("groups"),
      "toleranceDisconnectionTime": toleranceTimeInSeconds
    };
    return await send(syncMessage);
  }

  static Future<String?> sendStartServiceMessage() async {
    final Map<String, dynamic> message = {
      "type": "START",
      "alert": AlertService.selectedAlert?.toJson(),
      "group": AlertService.selectedGroup?.toJson(),
      "toleranceDisconnectionTime": toleranceTimeInSeconds
    };
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
          print("response from watch: $response");
        });

        while (DateTime.now().difference(startTime) < const Duration(milliseconds: 2000)) {
          await Future.delayed(const Duration(milliseconds: 100));
          if (response.isNotEmpty) {
            print(response);
            _subscription?.cancel();
            return null;
          }
        }
        return "Tiempo de espera ha sido excedido";
      } catch (e) {
        return "Error";
      }
    } else {
      return "Error";
    }
  }

  // * --------------------- >>> DATA RECEPTION METHODS <<< --------------------------------- * //
  static bool processMessageFromWatch(Map<String, dynamic> data) {
    FlutterLogs.logInfo("SmartWatchService", "ProcessMessageFromWatch", "Message received with data: $data");
    switch (data['type']) {
      case 'START':
        processStartServiceMessage(data);
        break;
      case 'STOP':
        break;
      case 'ACTIVATE':
        break;
      case 'CANCEL':
      default:
    }

    return true;
  }

  static Future<void> processStartServiceMessage(Map<String, dynamic> data) async {
    FlutterLogs.logInfo(
        "SmartwatchService", "ProccessStartServiceMessage", "Trying to start service from smartwatch...");

    AlertService.selectedAlert = Alert.fromJson(data['alert']);
    AlertService.selectedGroup = Group.fromJson(data['group']);
    final serviceResponse = await AlertService.initServiceManually();
    if (serviceResponse == null) {
      if (homeProvider != null && bottomBarProvider != null) {
        homeProvider!.startServiceStateFromWatch();
        bottomBarProvider!.enableAlertButton();
      }
    }
  }
}
