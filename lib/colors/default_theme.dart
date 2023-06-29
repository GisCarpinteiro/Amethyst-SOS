import 'package:flutter/material.dart';

//TODO: Maybe a JSON would be a better and more universal option.
//En esta clase
abstract class CustomThemes{
  static Map<String, Color> defaultTheme = {
    'btn_bg' : const Color(0x00EF8496),
    'btn_foreground' : const Color (0xFFFFFFFF)
  };
}