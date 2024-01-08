// This class is the one in charge to define and control the logic of the service of alert activation based on the configurations for each alert
// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:vistas_amatista/api/rest_alert_connector.dart';
import 'package:vistas_amatista/models/alert.dart';
import 'package:vistas_amatista/models/group.dart';
import 'package:vistas_amatista/services/disconnection_service.dart';
import 'package:vistas_amatista/services/location_service.dart';
import 'package:vistas_amatista/services/permissions_manager.dart';
import 'package:vistas_amatista/services/smartwatch_service.dart';
import 'package:vistas_amatista/services/trigger_services/backtap_trigger_service.dart';
import 'package:vistas_amatista/services/trigger_services/button_trigger_service.dart';
import 'package:vistas_amatista/services/trigger_services/internet_disconnection_service.dart';
import 'package:vistas_amatista/services/trigger_services/smartwatch_disconnection_service.dart';
import 'package:vistas_amatista/services/trigger_services/smartwatch_trigger_service.dart';
import 'package:vistas_amatista/services/trigger_services/voice_trigger_service.dart';

import '../resources/custom_widgets/msos_snackbar.dart';

class AlertService {
  static const UPDATE_LOCATION_FAILURE =
      "No fué posible actualizar la ubicación en el servidor para el servicio de activación por desconexión, conéctese a internet y trate de detener el servicio para evitar una falsa alarma";
  static const SMARTWATCH_HAS_DISCONNECTED =
      "El smartwatch se ha desconectado, lo que ha provocado que se dispare la cuenta regresiva para activar las alertas";
  static const DISCONNECTION_SERVICE_ALERTED =
      "El servidor ha enviado los mensajes de alerta debido a una desconexión prolongada";
  // TriggerServices
  final ButtonTriggerService buttonTriggerService = ButtonTriggerService();
  final BacktapTriggerService backtapTriggerService = BacktapTriggerService();
  final DisconnectionTriggerService internetDisconnectionTrigger = DisconnectionTriggerService();
  final SmartwatchDisconnetionService smartwatchDisconnetionService = SmartwatchDisconnetionService();
  final SmartwatchTriggerService smartwatchTriggerService = SmartwatchTriggerService();
  final VoiceTriggerService voiceTriggerService = VoiceTriggerService();

  static Alert? selectedAlert;
  static Group? selectedGroup;
  static BuildContext? homeContext;
  static bool isServiceActive = false;
  static AlertState alertState = AlertState.disabled;
  static bool basicPermissionsSatisfied = false;
  static int timeLeft = 0;
  static Set<String> activeMessages = <String>{
    "Este es un mensaje de notificación",
    "Y este de acá simplemente es otro, no paran de salir, de hecho este es hasta un poco más largo"
  };

  static bool isCountdownActive = false;
  static StreamSubscription<int>? countdownStream;
  static int countdown = 0;

  // This method is used when starting service from the Home Screen and pressing the start service Button
  static Future<String?> start({bool fromWatch = false}) async {
    // Verify that there's an alert selected
    if (selectedAlert == null) {
      FlutterLogs.logError(
          "AlertManager", "initServiceManually()", "No alert has been selected to start the alert service");
      return "No se ha seleccionado una alerta para iniciar el servicio";
    } else if (selectedGroup == null) {
      FlutterLogs.logError(
          "AlertManager", "initServiceManually()", "No group has been seleted to start the alert service");
      return "No se ha seleccionado un grupo para iniciar el servicio";
    }

    // * First we check if needed permissions have been granted. if not, we try to ask for them.
    if (!basicPermissionsSatisfied) {
      basicPermissionsSatisfied = await PermissionsManager.requestAllBasicPermissions();
      if (!basicPermissionsSatisfied) {
        FlutterLogs.logError("AlertManager", "InitServiceManually()",
            "One or more basic permissions have not been granted, canceling service start");
        return "Uno o más premisos básicos no se han otorgados, aseguresé de haberlos aceptado o hágalo desde el menú de configuración del dispositivo";
      }
    }
    // * We confirm that the location service is able to provide us the locations
    if (!await LocationService.initLocationService()) {
      FlutterLogs.logError("AlertManager", "InitServiceManually()", "Location Service failed to start");
      return "El servicio de ubicación no pudo iniciar, asegurate de haber concedido los permisos correspondientes";
    }

    FlutterLogs.logInfo("AlertManager", "InitServiceManually()", "ALERT SERVICE STARTED");
    isServiceActive = true;
    alertState = AlertState.inactive;
    // Start all the configured trigger services:
    if (!initServices(fromWatch: fromWatch)) {
      FlutterLogs.logError("AlertManager", "InitServiceManually()", "One or more services couldn't start");
    }
    return null;
  }

  static Future<String?> stop() async {
    if (isCountdownActive) {
      final response = await RestConnector.cancelAlertMessage();
      if (!response) {
        FlutterLogs.logError("AlertManager", "stopService()", "One or more services couldn't been stoped!");
      }
      cancelAlert();
    }
    if (!stopServices()) {
      FlutterLogs.logError("AlertManager", "stopService()", "One or more services couldn't been stoped!");
      return "No todos los servicios de activadores pudieron ser detenidos!";
    }
    isServiceActive = false;
    return null;
  }

  static bool initServiceWithRoutine(
      {required Alert routineAlert, required Group routineGroup, Duration? desactivationTime}) {
    return true;
  }

  static void activateAlertCountdown(
      {required int toleranceSeconds, required void Function(int) onEvent, required void Function() onDone}) {
    countdownStream?.cancel();
    onEvent(toleranceSeconds);
    //First we need to create the countdown stream to end it until
    countdownStream =
        Stream<int>.periodic(const Duration(seconds: 1), (value) => value).take(toleranceSeconds).listen((eventValue) {
      if (eventValue == toleranceSeconds - 1) {
        onDone();
      }
      timeLeft = toleranceSeconds - 1 - eventValue;
      onEvent(timeLeft);
    });
  }

  static Future<bool> cancelAlert() async {
    FlutterLogs.logInfo("AlertService", "cancelAlert", "Trying to cancel alert");
    final result = await RestConnector.cancelAlertMessage();
    if (result) {
      FlutterLogs.logInfo("AlertService", "cancelAlert", "SUCCESS: Alert was succesfully canceled");
      isCountdownActive = false;
      isCountdownActive = false;
      await countdownStream?.cancel();
      return true;
    }
    FlutterLogs.logError(
        "AlertService", "cancelAlert", "FAILURE: The alert was not canceled due to an error on server");
    return false;
  }

  static bool initServices({bool fromWatch = false}) {
    FlutterLogs.logInfo("AlertService", "initServices", "Trying to start the services");

    if (selectedAlert!.triggers[Alert.internetDisconnectionTrigger] && DisconnectionService.isServiceEnabled) {
      FlutterLogs.logInfo("AlertService", 'initServices', 'Starting Internet Disconnection Service...');
      DisconnectionService.startDisconnectionService();
    }

    if (selectedAlert!.triggers[Alert.smartwatchTrigger] && !fromWatch) {
      if (SmartwatchService.isReachable) {
        FlutterLogs.logInfo("AlertService", "initServices", "SMARTWATCH: Trying to start smartwatch service");
        SmartwatchService.sendStartServiceMessage().then((value) {
          if (value != null) {
            FlutterLogs.logError("Home", "StartSmartwatchAlertService",
                "SMARTWATCH: The following error occurred when trying to init service on smartwatch: $value");
            MSosFloatingMessage.showMessage(homeContext!, message: value, type: MSosMessageType.error);
          } else {
            FlutterLogs.logInfo(
                "Home", "StartSmartwatchAlertService", "SMARTWATCH: The service has started on smartwatch too");
            if (selectedAlert!.triggers[Alert.smartwatchDisconnectionTrigger]) {
              FlutterLogs.logInfo("AlertService", 'initServices', 'Starting Smartwatch Disconnection Service...');
              SmartwatchService.startSmartwatchDisconnectionService();
            }
          }
        });
      } 
    }

    return true;
  }

  static bool stopServices() {
    if (selectedAlert!.triggers[Alert.internetDisconnectionTrigger]) {
      DisconnectionService.stopDisconnectionService();
    }

    if (selectedAlert!.triggers[Alert.smartwatchTrigger]) {
      SmartwatchService.sendStopServiceMessage();
    }

    if (selectedAlert!.triggers[Alert.smartwatchDisconnectionTrigger]) {
      SmartwatchService.stopSmartwatchDisconnectionService();
    }
    return true;
  }
}
