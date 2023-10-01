import 'package:vistas_amatista/services/trigger_services/trigger_service.dart';

class ButtonTriggerService implements TriggerService {
  static bool hasPermissions = false;
  static bool isActive = false;

  @override
  activate() {
    hasPermissions = true;
  }

  @override
  askForPermissions() {
    throw UnimplementedError();
  }

  @override
  desactivate() {
    throw UnimplementedError();
  }
}
