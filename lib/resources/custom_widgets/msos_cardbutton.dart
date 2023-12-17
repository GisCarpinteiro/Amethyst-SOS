// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

class MSosCardButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color disabledBackgroundColor;
  final VoidCallback onPressed;
  final bool isDisabled;

  const MSosCardButton({
    this.title = "hello world",
    this.icon = Icons.play_arrow,
    this.backgroundColor = MSosColors.pink,
    this.foregroundColor = MSosColors.white,
    this.disabledBackgroundColor = MSosColors.grayMedium,
    this.isDisabled = false,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: isDisabled ? disabledBackgroundColor : backgroundColor,
              padding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: isDisabled ? MSosColors.grayDark : MSosColors.darkPink, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              elevation: 2,
              shadowColor: MSosColors.grayLight),
          onPressed: onPressed,
          child: SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 70,
                    child: MSosText(
                      title,
                      alignment: TextAlign.start,
                      isMultiline: true,
                      textColor: foregroundColor,
                    ),
                  ),
                  FaIcon(
                    icon,
                    size: 28,
                    color: foregroundColor,
                  )
                ],
              ),
            ),
          )),
    );
  }
}
