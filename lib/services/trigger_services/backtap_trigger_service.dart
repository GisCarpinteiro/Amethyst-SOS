import 'package:vistas_amatista/services/trigger_services/trigger_service.dart';

class BacktapTriggerService implements TriggerService {
  static bool hasPermissions = false;
  static bool isActive = false;
  
  @override
  activate() {
    throw UnimplementedError();
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
