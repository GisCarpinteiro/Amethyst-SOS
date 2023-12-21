import 'package:flutter/cupertino.dart';
import 'package:vistas_amatista/services/disconnection_service.dart';

class DisconnectionProvider with ChangeNotifier {
  int toleranceTimeOption = 2;
  bool isGlobalyEnabled = DisconnectionService.isServiceEnabled;
  int toleranceMinutes = DisconnectionService.toleranceMinutes;

  void changeToleranceOption(int option) {
    const timeValues = [1, 2, 5, 10];
    toleranceTimeOption = option;
    DisconnectionService.toleranceMinutes = timeValues[option];
    notifyListeners();
  }

  void toggleGlobalyEnabled(bool value) {
    isGlobalyEnabled = value;
    DisconnectionService.isServiceEnabled = value;
    notifyListeners();
  }
}
