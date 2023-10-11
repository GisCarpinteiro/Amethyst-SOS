import 'package:flutter/material.dart';

class ButtomBarProvider with ChangeNotifier {
  bool alertButtonEnabled = false;

  void enableAlertButton() {
    alertButtonEnabled = true;
    notifyListeners();
  }

  void disableAlertButton() {
    alertButtonEnabled = false;
    notifyListeners();
  }
}
