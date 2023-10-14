import 'package:flutter/material.dart';

class BottomBarProvider with ChangeNotifier {
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
