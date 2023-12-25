// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:http/http.dart' as http;
import 'package:vistas_amatista/controller/shared_preferences_manager.dart';
import 'package:vistas_amatista/models/alert.dart';
import 'package:vistas_amatista/models/group.dart';
import 'package:vistas_amatista/services/location_service.dart';

class RestConnector {
  static const String LOCALHOST = 'http://10.0.2.2:8080';
  static const String ALERTS_SERVICE_ROUTE = '/alerts';
  static const String DISSCONNECTION_SERVICE = "/services/disconnection";
  static const String CLOUD_SERVER = '';
  static final sharedPrefsInsance = SharedPrefsManager.sharedInstance;

  // * -------------------->>> request under the path /alerts <<< ------------------- * //

  static Future<bool> sendAlertMessage(Alert alert, Group group) async {
    const uri = LOCALHOST + ALERTS_SERVICE_ROUTE;
    final String? userId = sharedPrefsInsance!.getString('id');
    final String? location = (await LocationService.getCurrentLocation());

    if (userId == null || location == null) return false;

    final Map<String, dynamic> data = {
      "message": alert.message,
      "contacts": group.contacts.map((contact) {
        return contact['phone'];
      }).toList(),
      //"location": "${position.latitude},${position.longitude}",
      "userId": userId,
      "activationMethod": "NOT_IMPLEMENTED",
      "useSms": false,
      "useWApp": true,
      "location": location,
      "tolerance": alert.toleranceSeconds,
    };

    FlutterLogs.logInfo("RestConnector", "sendAlertMessage",
        "An alert message request is trying to be send to: $uri with message: \n$data");

    String messageAsJson = jsonEncode(data);

    try {
      http.Response response = await http
          .post(Uri.parse(uri),
              headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'}, body: messageAsJson)
          .timeout(const Duration(milliseconds: 2000));
      if (response.statusCode == 200) {
        FlutterLogs.logInfo("RestConnector", "sendAlertMessage",
            "SUCCESS: The alert message was succesfully send to server and is waiting for a cancelation message within the tolerance time before being send");
        return true;
      } else {
        FlutterLogs.logError("RestConnector", "sendAlertMessage",
            "FAILURE: Error while sending POST request to server with status: ${response.statusCode} and body: ${response.body}");
        return false;
      }
    } catch (e) {
      FlutterLogs.logError("RestConnector", "sendAlertMessage", "FAILURE: There was an error sending the message: $e");
      return false;
    }
  }

  static Future<bool> cancelAlertMessage() async {
    final String? userId = sharedPrefsInsance!.getString('id');
    final uri = "$LOCALHOST$ALERTS_SERVICE_ROUTE/$userId";
    try {
      http.Response response = await http.delete(Uri.parse(uri)).timeout(const Duration(milliseconds: 2000));
      if (response.statusCode == 204) {
        FlutterLogs.logInfo("RestController", "cancelAlertMessage", "SUCCESS: the alert message has been canceled");
        return true;
      } else {
        FlutterLogs.logError("RestConnector", "sendAlertMessage",
            "FAILURE: Error while sending DELETE request to server with status: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      FlutterLogs.logError("RestConnector", "sendAlertMessage", "FAILURE: There was an error sending the message: $e");
      return false;
    }
  }

  // * ----------------------------->>> Requests under the path /services/disconnection <<<------------------------- * //

  static Future<bool> postDisconnectionService(Map<String, dynamic> requestBody) async {
    const uri = LOCALHOST + DISSCONNECTION_SERVICE;

    String json = jsonEncode(requestBody);

    try {
      http.Response response = await http
          .post(Uri.parse(uri),
              headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'}, body: json)
          .timeout(const Duration(milliseconds: 2000));
      if (response.statusCode == 201) {
        return true;
      } else {
        FlutterLogs.logError("RestController", "postDisconnectionService",
            "Couldn't start disconnection service, response status code: ${response.statusCode}");
      }
    } catch (e) {
      FlutterLogs.logError(
          "RestController", "postDisconnectionService", "Error while requesting to start disconnection service: $e");
    }
    return false;
  }

  static Future<bool> terminateDisconnectionService(String userid) async {
    final uri = "$LOCALHOST$DISSCONNECTION_SERVICE/user/$userid";

    try {
      http.Response response = await http.delete(Uri.parse(uri)).timeout(const Duration(milliseconds: 2000));
      if (response.statusCode == 200) {
        return true;
      } else {
        FlutterLogs.logError("RestController", "postDisconnectionService",
            "Couldn't stop disconnection service, response status code: ${response.statusCode}");
      }
    } catch (e) {
      FlutterLogs.logError(
          "RestController", "postDisconnectionService", "Error while requesting to start disconnection service: $e");
    }
    return false;
  }

  static Future<bool> updateDisconnectionServiceLocation(String userid, String location) async {
    final uri = "$LOCALHOST$DISSCONNECTION_SERVICE/user/$userid";
    try {
      http.Response response = await http.put(Uri.parse(uri),
          headers: <String, String>{"location": location}).timeout(const Duration(milliseconds: 1000));
      if (response.statusCode == 200) {
        return true;
      } else {
        FlutterLogs.logError("RestController", "updateDisconnectionService",
            "Couldn't update location, response status code: ${response.statusCode}");
      }
    } catch (e) {
      FlutterLogs.logError("RestController", "updateDisconnectionService",
          "Error while requesting to update location for disconnection service: $e");
    }
    return false;
  }
}
