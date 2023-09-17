import 'package:flutter/material.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

class MsosSmallButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color foregroundColor;
  final IconData? icon;
  final VoidCallback callbackFunction;

  const MsosSmallButton(
      {super.key,
      required this.text,
      this.color = MSosColors.blue,
      this.foregroundColor = Colors.white,
      this.icon,
      required this.callbackFunction});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: callbackFunction,
      style: TextButton.styleFrom(
          elevation: 2,
          shadowColor: MSosColors.grayLight,
          backgroundColor: color,
          foregroundColor: foregroundColor),
      child: MSosText(
        text,
        style: MSosText.buttonStyle,
        size: 14,
      ),
    );
  }
}
