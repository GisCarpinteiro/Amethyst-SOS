import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistas_amatista/providers/bottombar_provider.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/custom_buttons/msos_multi_option_button.dart';
import 'package:vistas_amatista/resources/custom_widgets/custom_buttons/msos_small_button.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

/* Este es un widget custom para definir los estilos o plantillas de los botones 
que son usados de forma recurrente en la aplicación */

enum MSosButtonStyle { continueLargeBtn, subMenuLargeBtn, smallButton, multiOptionButton }

class MSosButton extends StatelessWidget {
  static const continueLargeBtn = 0; // wizard btn style for "continue" kind of options
  static const subMenuLargeBtn = 1;
  static const smallButton = 2;
  static const multiOptionButton = 3;

  final String text;
  final String? route;
  final int style;
  final IconData? icon;
  final Color textColor;
  final Color color;
  final VoidCallback? onPressed;

  const MSosButton(
      {required this.text,
      this.route,
      super.key,
      required this.style,
      this.icon,
      this.color = MSosColors.pink,
      this.textColor = MSosColors.white,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case MSosButton.smallButton:
        return MsosSmallButton(
            text: text, color: color, foregroundColor: textColor, icon: icon, callbackFunction: onPressed ?? () {});
      case MSosButton.multiOptionButton:
        return MSosMultiOptionButton(text: text, callbackFunction: onPressed ?? () {});
      case MSosButton.continueLargeBtn:
        return Row(children: [
          Expanded(
            child: TextButton(
                style: TextButton.styleFrom(
                  elevation: 2,
                  shadowColor: MSosColors.grayLight,
                  backgroundColor: color,
                ),
                onPressed: () {
                  if (onPressed != null) {
                    onPressed!();
                  } else {
                    Navigator.pushNamed(context, route ?? './not_found');
                  } // go to next screen
                },
                child: MSosText(
                  text,
                  style: MSosText.buttonStyle,
                  textColor: textColor,
                )),
          ),
        ]);
      case MSosButton.subMenuLargeBtn:
        return Row(children: [
          Expanded(
            child: TextButton(
                style: TextButton.styleFrom(
                    elevation: 2,
                    shadowColor: MSosColors.grayLight,
                    backgroundColor: MSosColors.white,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                onPressed: () {
                  if (onPressed != null) {
                    onPressed!();
                  } else {
                    Navigator.pushNamed(context, route ?? './not_found');
                  } // go to next screen
                },
                child: Row(
                  children: [
                    Icon(
                      icon,
                      color: MSosColors.grayMedium,
                    ),
                    const SizedBox(
                      width: 10,
                      height: 40,
                    ),
                    MSosText(
                      text,
                      size: 16,
                      style: MSosText.buttonStyle,
                      textColor: MSosColors.grayMedium,
                    ),
                  ],
                )),
          ),
        ]);
      default:
        return TextButton(
            style: TextButton.styleFrom(),
            onPressed: () {},
            child: MSosText(
              text,
              style: MSosText.buttonStyle,
            ));
    }
  }
}
