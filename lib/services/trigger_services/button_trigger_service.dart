import 'package:vistas_amatista/services/trigger_services/trigger_service.dart';

class ButtonTriggerService extends TriggerService {
  static bool hasPermissions = false;
  static bool isActive = false;

  @override
  activate() {
    
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
