import 'dart:io' show Platform;
import 'package:permission_handler/permission_handler.dart';
import 'package:vistas_amatista/services/trigger_services/trigger_service.dart';

class VoiceTriggerService extends TriggerService {
  static bool hasPermissions = false;
  static bool isActive = false;

  @override
  Future<bool> activate() async {
    // First check of the permissions. if no permissions try to ask for them
    if (!hasPermissions) hasPermissions = askForPermissions() as bool;
    // Secon check of the permissions. If not granted return false
    if (hasPermissions) {
      // TODO: Activación del servicio.

      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> askForPermissions() async {
    // * Asking for permissions on Android Platform.
    if (Platform.isAndroid) {
      final status = await Permission.microphone.request();
      switch (status) {
        case PermissionStatus.granted:
          hasPermissions = true;
          return true;
        // case PermissionStatus.restricted:
        // TODO: Investigar si el servicio puede seguir funcionando en segundo plano
        // case PermissionStatus.limited:
        // TODO: Investigar si el servicio puede seguir funcionando en segundo plano
        default:
          hasPermissions = false;
          return false;
      }
    } else if (Platform.isIOS) {
      // TODO: (GISEL) Añadir el método para pedir permiso de acceso al micrófono en iOS.
      // * Puedes basarte en este tutorial de Herrera: https://youtu.be/6Ral4D3X9fE?si=V5kr9lNE1DxMHKof
    }

    return false;
  }

  @override
  desactivate() {
    throw UnimplementedError();
  }
}
