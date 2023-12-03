import 'dart:async';

import 'package:vistas_amatista/controller/shared_preferences_manager.dart';
import 'package:vistas_amatista/services/alert_services/alert_manager.dart';
import 'package:watch_connectivity/watch_connectivity.dart';

class SmartwatchService {
  static final sharedPrefsInstance = SharedPrefsManager.sharedInstance;
  static final watchConnection = WatchConnectivity();
  static bool isSynchronized = false;
  static bool isReachable = false;
  static int toleranceTimeInSeconds = 120;
  static StreamSubscription<Map<String, dynamic>>? _subscription;

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
    startListening2Watch();
    if (await checkIfReachable()) {
      try {
        final startTime = DateTime.now();
        await watchConnection.sendMessage({
          "type": "SYNCHRONIZATION",
          "alerts": sharedPrefsInstance?.get("alerts"),
          "groups": sharedPrefsInstance?.get("groups"),
          "isServiceActive": AlertService.isServiceActive,
          "toleranceDisconnectionTime": toleranceTimeInSeconds
        });
        // We need to wait for a response from the watch to know that the sync message has been received
        Map<String, dynamic> response = {};
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
        print("fallo");
        return "Timepo de espera ha sido excedido";
      } catch (e) {
        return "Error";
      }
    } else {
      return "Error";
    }
  }

  // TODO: Process Message!!!
  static bool processMessageFromWatch(Map<String, dynamic> message) {
    print("processing: $message");
    return true;
  }

  // TODO: SendMessage!!!
  static Future<bool> sendMessageFromWatch() async {
    return false;
  }
}
