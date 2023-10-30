// * INFO: This provider is used for a general state of the app like checking if user was already logged in.

import 'package:flutter/material.dart';

class MainProvider with ChangeNotifier{
  bool loggedIn = false;
}