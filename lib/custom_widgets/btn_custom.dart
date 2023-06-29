import 'package:flutter/material.dart';
import 'package:vistas_amatista/custom_widgets/text_custom.dart';

class BtnCustomWidget extends StatelessWidget {
  static const continueLargeBtn = 0; // wizard btn style for "continue" kind of options

  final String text;
  final String route;
  final int style;

  const BtnCustomWidget(
      {
      required this.text,
      required this.route,
      super.key,
      required this.style
  });

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case BtnCustomWidget.continueLargeBtn:
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
                child: TextCustomWidget(
                  text,
                  style: TextCustomWidget.buttonStyle,
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
          child: TextCustomWidget(
            text,
            style: TextCustomWidget.buttonStyle,
          )
        );
    }
  }
}