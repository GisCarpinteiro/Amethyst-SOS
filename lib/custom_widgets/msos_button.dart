import 'package:flutter/material.dart';
import 'package:vistas_amatista/custom_widgets/msos_text.dart';

/* Este es un widget custom para definir los estilos o plantillas de los botones 
que son usados de forma recurrente en la aplicación */

class MSosButton extends StatelessWidget {
  static const continueLargeBtn = 0; // wizard btn style for "continue" kind of options
  static const subMenuLargeBtn = 1;

  final String text;
  final String route;
  final int style;
  final IconData? icon;
  final Color? textColor;

  const MSosButton(
      {
      required this.text,
      required this.route,
      super.key,
      required this.style,
      this.icon,
      this.textColor
  });

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case MSosButton.continueLargeBtn:
        return Row(
          children: [
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor:const Color(0xFFEF8496),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, route); // go to next screen
                }, 
                child: MSosText(
                  text,
                  style: MSosText.buttonStyle,
                  textColor: textColor?? const Color(0xFFFFFFFF),
                )
              ),
            ),
          ]
        );
      case MSosButton.subMenuLargeBtn:
        return Row(
          children: [
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor:const Color(0xFFFFFFFF),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  )
                ),
                onPressed: () {
                  Navigator.pushNamed(context, route); // go to next screen
                }, 
                child: Row(
                  children: [
                    Icon(icon, color: textColor?? const Color(0xFF5E5D5D),),
                    const SizedBox(width: 10, height: 40,),
                    MSosText(
                      text,
                      size: 16,
                      style: MSosText.buttonStyle,
                      textColor: textColor?? const Color(0xFF5E5D5D),
                    ),
                  ],
                )
              ),
            ),
          ]
        );
      default:
        return TextButton(
          style: TextButton.styleFrom(
          ),
          onPressed: () {
          }, 
          child: MSosText(
            text,
            style: MSosText.buttonStyle,
          )
        );
    }
  }
}