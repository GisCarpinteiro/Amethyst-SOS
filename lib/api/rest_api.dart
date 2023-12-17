import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:vistas_amatista/controller/shared_preferences_manager.dart';
import 'package:vistas_amatista/models/alert.dart';
import 'package:vistas_amatista/models/group.dart';

class RestConnector {
  static const String alertServiceUri = 'http://10.0.2.2:8080/alerts';
  static final sharedPrefsInsance = SharedPrefsManager.sharedInstance;

  static Future<String?> sendAlertMessage(Alert alert, Group group) async {

    final String? userId = sharedPrefsInsance!.getString('userId');

    final Map<String, dynamic> data = {
      "message": alert.message,
      "contacts": group.contacts.map((contact) {
        return contact['name'];
      }).toList(),
      //"location": "${position.latitude},${position.longitude}",
      "userId": userId,
      "activationMethod": "NOT_IMPLEMENTED",
      "useSms": false,
      "useWApp": true,
    };

    print(data);
  }

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
}
