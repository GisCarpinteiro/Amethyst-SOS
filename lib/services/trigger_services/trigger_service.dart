import 'package:flutter_logs/flutter_logs.dart';

abstract class TriggerService {
  openSettingsApp() {
    FlutterLogs.logInfo("TriggerService (abstract service)", "openSettingsApp", "trying to open the settings app to enable permissions");
    // Open settings app
  }

  askForPermissions() {}
  activate() {}
  desactivate() {}
}
