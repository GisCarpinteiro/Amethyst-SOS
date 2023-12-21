// This class is the one in charge to define and control the logic of the service of alert activation based on the configurations for each alert
// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_logs/flutter_logs.dart';
import 'package:vistas_amatista/models/alert.dart';
import 'package:vistas_amatista/models/group.dart';
import 'package:vistas_amatista/providers/home_provider.dart';
import 'package:vistas_amatista/services/disconnection_service.dart';
import 'package:vistas_amatista/services/location_service.dart';
import 'package:vistas_amatista/services/permissions_manager.dart';
import 'package:vistas_amatista/services/trigger_services/backtap_trigger_service.dart';
import 'package:vistas_amatista/services/trigger_services/button_trigger_service.dart';
import 'package:vistas_amatista/services/trigger_services/internet_disconnection_service.dart';
import 'package:vistas_amatista/services/trigger_services/smartwatch_disconnection_service.dart';
import 'package:vistas_amatista/services/trigger_services/smartwatch_trigger_service.dart';
import 'package:vistas_amatista/services/trigger_services/voice_trigger_service.dart';

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
  static bool isServiceActive = false;
  static AlertState alertState = AlertState.disabled;
  static bool basicPermissionsSatisfied = false;
  static Set<String> activeMessages = <String>{
    "Este es un mensaje de notificación",
    "Y este de acá simplemente es otro, no paran de salir, de hecho este es hasta un poco más largo"
  };

  static bool isCountdownActive = false;
  static StreamSubscription<int>? countdownStream;
  static int countdown = 0;

  static postBackend(String userId) async {
    const url = 'http://10.0.2.2:8080/services/disconnection';
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
    // * We confirm that the location service is able to provide us the locations
    if (!await LocationService.initLocationService()) {
      FlutterLogs.logError("AlertManager", "InitServiceManually()", "Location Service failed to start");
      return "El servicio de ubicación no pudo iniciar, asegurate de haber concedido los permisos correspondientes";
    }
    // * Then we try to send a ping to the server to start communications and send messages.

    // * Then we will start the stream in charge to update location on the alert service periodically

    // * Then, if disconnection service is enabled we start the stream in charge to send updates to the server

    FlutterLogs.logInfo("AlertManager", "InitServiceManually()", "ALERT SERVICE STARTED");
    isServiceActive = true;
    alertState = AlertState.inactive;
    // Start all the configured trigger services:
    if (!initTriggerServices()) {
      FlutterLogs.logError("AlertManager", "InitServiceManually()", "One or more services couldn't start");
    }
    return null;
  }

  static Future<String?> stopService() async {
    if (!stopTriggerServices()) {
      FlutterLogs.logError("AlertManager", "stopServices()", "One or more services couldn't been stoped!");
      return "No todos los servicios de activadores pudieron ser detenidos!";
    }
    isServiceActive = false;
    return null;
  }

  static bool initServiceWithRoutine(
      {required Alert routineAlert, required Group routineGroup, Duration? desactivationTime}) {
    return true;
  }

  static void startActivationCountdown(
      {required int toleranceSeconds, required void Function(int) onEvent, required void Function() onDone}) {
    countdownStream?.cancel();
    onEvent(toleranceSeconds);
    //First we need to create the countdown stream to end it until
    countdownStream =
        Stream<int>.periodic(const Duration(seconds: 1), (value) => value).take(toleranceSeconds).listen((eventValue) {
      if (eventValue == toleranceSeconds - 1) {
        onDone();
      }
      onEvent(toleranceSeconds - 1 - eventValue);
    });
  }

  static Future<void> stopActivationCountdown() async {
    await countdownStream?.cancel();
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
      DisconnectionService.stopDisconnectionService();
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
