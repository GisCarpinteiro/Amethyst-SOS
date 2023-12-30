import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:vistas_amatista/controller/shared_preferences_manager.dart';
import 'package:vistas_amatista/services/smartwatch_service.dart';

class SmartwatchProvider with ChangeNotifier {
  bool isSync = false;
  bool isReachable = false;
  int toleranceTimeOption = 0;
  bool isSyncLoading = false;
  bool automaticSincronization = SmartwatchService.automaticSync;
  final sharedPrefsInstance = SharedPrefsManager.sharedInstance;

  void updateState({bool? isSync, bool? isReachable}) {
    if (isSync != null) this.isSync = isSync;
    if (isReachable != null) this.isReachable = isReachable;
  }

  Future<String?> syncWatch() async {
    isSyncLoading = true;
    notifyListeners();
    FlutterLogs.logInfo("SmartwatchProvider", "syncWatch", "Trying to sync up with the smartwatch");
    return await SmartwatchService.sendSyncMessage().then((value) {
      isSyncLoading = false;
      notifyListeners();
      return value;
    });
  }

  void changeToleranceOption(int option) {
    toleranceTimeOption = option;
    notifyListeners();
  }

  void changeAutomaticSincronization(bool option) {
    SmartwatchService.automaticSync = option;
    automaticSincronization = option;
    notifyListeners();
  }

  void saveChanges() {}
}
