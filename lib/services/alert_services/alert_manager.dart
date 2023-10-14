// This class is the one in charge to define and control the logic of the service of alert activation based on the configurations for each alert
import 'package:flutter_logs/flutter_logs.dart';
import 'package:vistas_amatista/models/alert.dart';
import 'package:vistas_amatista/models/group.dart';
import 'package:vistas_amatista/services/alert_services/permissions_manager.dart';
import 'package:vistas_amatista/services/trigger_services/backtap_trigger_service.dart';
import 'package:vistas_amatista/services/trigger_services/button_trigger_service.dart';
import 'package:vistas_amatista/services/trigger_services/internet_disconnection_service.dart';
import 'package:vistas_amatista/services/trigger_services/smartwatch_disconnection_service.dart';
import 'package:vistas_amatista/services/trigger_services/smartwatch_trigger_service.dart';
import 'package:vistas_amatista/services/trigger_services/voice_trigger_service.dart';

class AlertManager {
  final ButtonTriggerService buttonTriggerService = ButtonTriggerService();
  final BacktapTriggerService backtapTriggerService = BacktapTriggerService();
  final DisconnectionTriggerService internetDisconnectionTrigger = DisconnectionTriggerService();
  final SmartwatchDisconnetionService smartwatchDisconnetionService = SmartwatchDisconnetionService();
  final SmartwatchTriggerService smartwatchTriggerService = SmartwatchTriggerService();
  final VoiceTriggerService voiceTriggerService = VoiceTriggerService();

  static Alert? selectedAlert;
  static Group? selectedGroup;
  static bool isServiceActive = false;
  static bool basicPermissionsSatisfied = false;

  static Duration? programmedDesactivationTime;

  // This method is used when starting service from the Home Screen and pressing the start service Button
  static Future<bool> initServiceManually() async {
    // Verify that there's an alert selected
    if (selectedAlert == null) {
      FlutterLogs.logError("AlertManager", "initServiceManually()", "No alert has been selected to start the alert service");
      return false;
    } else if (selectedGroup == null) {
      FlutterLogs.logError("AlertManager", "initServiceManually()", "No group has been seleted to start the alert service");
    
      return false;
    }

    // * What do we need to do after activating an alert?

    // * First we check if needed permissions have been granted. if not, we try to ask for them.
    if (!basicPermissionsSatisfied) {
      basicPermissionsSatisfied = await PermissionsManager.requestAllBasicPermissions();
      if (!basicPermissionsSatisfied) {
        FlutterLogs.logError(
            "AlertManager", "InitServiceManually()", "One or more basic permissions have not been granted, canceling service start");
        return false;
      }
    }
    // Start all the configured trigger services:
    if (!initTriggerServices()) {
      FlutterLogs.logError("AlertManager", "InitServiceManually()", "One or more services couldn't initiate");
    }

    isServiceActive = true;

    return true;
  }

  stopService() {
    if (!stopTriggerServices()) {
      FlutterLogs.logError("AlertManager", "stopServices()", "One or more services couldn't been stoped!");
    }
    isServiceActive = false;
  }

  static bool initServiceWithRoutine({required Alert routineAlert, required Group routineGroup, Duration? desactivationTime}) {
    return true;
  }

  static bool initTriggerServices() {
    if (selectedAlert!.triggers[Alert.internetDisconnectionTrigger]) {
      // TODO: Implementar la inicialización del disconnection trigger
    }

    if (selectedAlert!.triggers[Alert.buttonTrigger]) {
      // TODO: Implementar la lógica necesaria para habilitar el botón como disparador
    }

    if (selectedAlert!.triggers[Alert.backtapTrigger]) {
      // TODO: Implementar el servicio de backtap para la activación de las alertas (Probablemente solo aplique para iOS)
    }

    if (selectedAlert!.triggers[Alert.voiceTrigger]) {
      // TODO: Implemenentar la lógica para habilitar y hacer uso del activador por comandos de voz
    }

    if (selectedAlert!.triggers[Alert.smartwatcTrigger]) {
      // TODO: Implementar la lógica para poder activar las alertas desde el smartawtch e iniciar la conexión con la app
    }

    if (selectedAlert!.triggers[Alert.smartwatchDisconnectionTrigger]) {
      // TODO: Crear la implementación de el servicio de desconexión a internet ()
    }

    return true;
  }

  static bool stopTriggerServices() {

    if (selectedAlert!.triggers[Alert.internetDisconnectionTrigger]) {
      // TODO: Implementar la inicialización del disconnection trigger
    }

    if (selectedAlert!.triggers[Alert.buttonTrigger]) {
      // TODO: Implementar la lógica necesaria para habilitar el botón como disparador
    }

    if (selectedAlert!.triggers[Alert.backtapTrigger]) {
      // TODO: Implementar el servicio de backtap para la activación de las alertas (Probablemente solo aplique para iOS)
    }

    if (selectedAlert!.triggers[Alert.voiceTrigger]) {
      // TODO: Implemenentar la lógica para habilitar y hacer uso del activador por comandos de voz
    }

    if (selectedAlert!.triggers[Alert.smartwatcTrigger]) {
      // TODO: Implementar la lógica para poder activar las alertas desde el smartawtch e iniciar la conexión con la app
    }

    if (selectedAlert!.triggers[Alert.smartwatchDisconnectionTrigger]) {
      // TODO: Crear la implementación de el servicio de desconexión a internet ()
    }
    return true;
  }
}
