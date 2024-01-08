

import 'package:flutter/material.dart';
import 'package:vistas_amatista/controller/shared_preferences_manager.dart';

class DashboardProvider with ChangeNotifier{
  String username = SharedPrefsManager.sharedInstance!.getString('name')?? 'NULL';
  String phone = SharedPrefsManager.sharedInstance!.getString('phone')?? 'NULL';
  String email = SharedPrefsManager.sharedInstance!.getString('email')?? 'NULL';
}