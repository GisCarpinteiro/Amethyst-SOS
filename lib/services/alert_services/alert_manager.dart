// This class is the one in charge to define and control the logic of the service of alert activation based on the configurations for each alert
import 'dart:convert';
import 'package:http/http.dart' as http;
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

class AlertService {
  final ButtonTriggerService buttonTriggerService = ButtonTriggerService();
  final BacktapTriggerService backtapTriggerService = BacktapTriggerService();
  final DisconnectionTriggerService internetDisconnectionTrigger = DisconnectionTriggerService();
  final SmartwatchDisconnetionService smartwatchDisconnetionService = SmartwatchDisconnetionService();
  final SmartwatchTriggerService smartwatchTriggerService = SmartwatchTriggerService();
  final VoiceTriggerService voiceTriggerService = VoiceTriggerService();

  static Alert? selectedAlert;
  static Group? selectedGroup;
  static bool isServiceActive = false;
  static AlertState alertState = AlertState.disabled;
  static bool basicPermissionsSatisfied = false;

  static Duration? programmedDesactivationTime;

  static postBackend(String userId) async {
    final url = 'http://10.0.2.2:8080/services/disconnection';
    Map<String, dynamic> data = {
      "alertMessage": "Necesito tu ayuda!",
      "contacts": ["3314237139", "3314237139"],
      "location": "NOT_IMPLEMENTED",
      "userId": userId
    };

    String json = jsonEncode(data);

    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'}, body: json);
      print('La respuesta del servidor fué: ${response.body}');
    } catch (e) {
      print('Error al enviar la solicitud: $e');
    }
  }

  static delBackend(String user) async {
    final url = 'http://10.0.2.2:8080/services/disconnection/user/$user';

    try {
      http.Response response = await http.delete(Uri.parse(url));
      print('La respuesta del servidor fué: ${response.body}');
    } catch (e) {
      print('Error al enviar la solicitud: $e');
    }
  }

  static putBackend(String user) async {
    final url = 'http://10.0.2.2:8080/services/disconnection/user/$user';

    try {
      http.Response response = await http.put(Uri.parse(url), body: "nueva ubicación!");
      print('La respuesta del servidor fué: ${response.body}');
    } catch (e) {
      print('Error al enviar la solicitud: $e');
    }
  }

  // This method is used when starting service from the Home Screen and pressing the start service Button
  static Future<String?> initServiceManually() async {
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

    // * What do we need to do after activating an alert?
    // * First we check if needed permissions have been granted. if not, we try to ask for them.
    if (!basicPermissionsSatisfied) {
      basicPermissionsSatisfied = await PermissionsManager.requestAllBasicPermissions();
      if (!basicPermissionsSatisfied) {
        FlutterLogs.logError("AlertManager", "InitServiceManually()",
            "One or more basic permissions have not been granted, canceling service start");
        return "Uno o más premisos básicos no se han otorgados, aseguresé de haberlos aceptado o hágalo desde el menú de configuración del dispositivo";
      }
    }
    FlutterLogs.logInfo("AlertManager", "InitServiceManually()", "ALERT SERVICE STARTED");
    isServiceActive = true;
    alertState = AlertState.inactive;
    // Start all the configured trigger services:
    if (!initTriggerServices()) {
      FlutterLogs.logError("AlertManager", "InitServiceManually()", "One or more services couldn't start");
    }
    return null;
  }

  static stopService() {
    if (!stopTriggerServices()) {
      FlutterLogs.logError("AlertManager", "stopServices()", "One or more services couldn't been stoped!");
    }
    isServiceActive = false;
  }

  static bool initServiceWithRoutine(
      {required Alert routineAlert, required Group routineGroup, Duration? desactivationTime}) {
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
