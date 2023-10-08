import 'dart:io';

import 'package:flutter_logs/flutter_logs.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsManager {
  // * This method contacts Permissions Manager to request for permissions and evalueate their Status.
  static Future<bool> requestAllBasicPermissions() async {
    if (requestLocationPermissions() as bool && requestSMSPermissions() as bool && requestNotificationPermissions() as bool) {
      FlutterLogs.logInfo(
          "PermissionsManager", "requestAllBasicPermissions()", "All basic permissions have been granted! ready to start service");
      return true;
    } else {
      FlutterLogs.logError(
          "PermissionsManager", "requestAllBasicPermissions()", "Not all basic permissions have been granted, can't start service");
      return false;
    }
  }

  // * LOCATION PERMISSIONS:
  static Future<bool> requestLocationPermissions() async {
    // Read the status of the permission.
    var status = await Permission.location.status;
    // We verify that the permissions still not being granted.
    if (status == PermissionStatus.denied) {
      FlutterLogs.logInfo("PermissionsManager", "requestLocationPermissions()", "Trying to request for permissions for location...");
      // if yes, then we try to ask for them
      // ? Maybe Android and iOS permissions should be handled separated
      if (Platform.isAndroid) {
        status = await Permission.location.request();
      }

      if (status != PermissionStatus.granted) return false;
      FlutterLogs.logInfo("PermissionsManager", "requestLocationPermissions()", "Permissions for location have been granted!.");
      return true;
    } else if (status == PermissionStatus.granted) {
      FlutterLogs.logInfo("PermissionsManager", "requestLocationPermissions()", "Permissions for location have already been granted!.");
      return true;
    } else {
      // TODO: Enviar al usuario a las configuraciones del celultar
      FlutterLogs.logWarn("PermissionsManager", "requestLocationPermissions()",
          "Permissions for Location are not granted and cannot grant them from app anymore. Need to set from settings");
      return false;
    }
  }

  // * NOTIFICATION PERMISSIONS:
  static Future<bool> requestNotificationPermissions() async {
    // Read the status of the permission.
    var status = await Permission.notification.status;
    // We verify that the permissions still not being granted.
    if (status == PermissionStatus.denied) {
      FlutterLogs.logInfo(
          "PermissionsManager", "requestNotificationPermissions()", "Trying to request for permissions for Notification...");
      // if yes, then we try to ask for them
      if (Platform.isAndroid) {
        status = await Permission.notification.request();
      }

      if (status != PermissionStatus.granted) return false;

      FlutterLogs.logInfo("PermissionsManager", "requestNotificationPermissions()", "Permissions for notification have been granted!.");
      return true;
    } else if (status == PermissionStatus.granted) {
      FlutterLogs.logInfo(
          "PermissionsManager", "requestNotificationPermissions()", "Permissions for notification have already been granted!.");
      return true;
    } else {
      // TODO: Enviar al usuario a las configuraciones del celultar
      FlutterLogs.logWarn("PermissionsManager", "requestNotificationPermissions()",
          "Permissions for notifications are not granted and cannot grant them from app anymore. Need to set from settings");
      return false;
    }
  }

  // * BLUETOOTH PERMISSIONS:
  static Future<bool> requestBluetoothPermissions() async {
    // Read the status of the permission.
    var status = await Permission.bluetooth.status;
    // We verify that the permissions still not being granted.
    if (status == PermissionStatus.denied) {
      FlutterLogs.logInfo("PermissionsManager", "requestBluetoothPermissions()", "Trying to request for permissions for bluetooth...");
      // if yes, then we try to ask for them

      if (Platform.isAndroid) {
        status = await Permission.bluetooth.request();
      }

      if (status != PermissionStatus.granted) return false;
      FlutterLogs.logInfo("PermissionsManager", "requestBluetoothPermissions()", "Permissions for bluetooth have been granted!.");
      return true;
    } else if (status == PermissionStatus.granted) {
      FlutterLogs.logInfo("PermissionsManager", "requestBluetoothPermissions()", "Permissions for bluetooth have already been granted!.");
      return true;
    } else {
      // TODO: Enviar al usuario a las configuraciones del celultar
      FlutterLogs.logWarn("PermissionsManager", "requestBluetoothPermissions()",
          "Permissions for Bluetooth are not granted and cannot grant them from app anymore. Need to set from settings");
      return false;
    }
  }

  // * SMS PERMISSIONS:
  static Future<bool> requestSMSPermissions() async {
    // Read the status of the permission.
    var status = await Permission.sms.status;
    // We verify that the permissions still not being granted.
    if (status == PermissionStatus.denied) {
      FlutterLogs.logInfo("PermissionsManager", "requestSMSPermissions()", "Trying to request for permissions for SMS...");
      // if yes, then we try to ask for them

      if (Platform.isAndroid) {
        status = await Permission.sms.request();
      }

      if (status != PermissionStatus.granted) return false;
      FlutterLogs.logInfo("PermissionsManager", "requestSMSPermissions()", "Permissions for SMS have been granted!.");
      return true;
    } else if (status == PermissionStatus.granted) {
      FlutterLogs.logInfo("PermissionsManager", "requestSMSPermissions()", "Permissions for SMS have already been granted!.");
      return true;
    } else {
      // TODO: Enviar al usuario a las configuraciones del celultar
      FlutterLogs.logWarn("PermissionsManager", "requestSMSPermissions()",
          "Permissions for SMS are not granted and cannot grant them from app anymore. Need to set from settings");
      return false;
    }
  }
}
