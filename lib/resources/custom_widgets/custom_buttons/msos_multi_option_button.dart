import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

class MSosMultiOptionButton extends StatelessWidget {
  final String text;
  final Color color = MSosColors.white;
  final Color foregroundColor = MSosColors.grayMedium;
  final VoidCallback callbackFunction;

  const MSosMultiOptionButton({super.key, required this.text, required this.callbackFunction});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: callbackFunction,
      style:
          TextButton.styleFrom(elevation: 2, shadowColor: MSosColors.grayLight, backgroundColor: color, foregroundColor: foregroundColor),
      child: SizedBox(
        width: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MSosText(
              text,
              textColor: foregroundColor,
              style: MSosText.buttonStyle,
              size: 14,
            ),
            const FaIcon(
              FontAwesomeIcons.circleChevronDown,
              color: MSosColors.grayLight,
            )
          ],
        ),
      ),
    );
  }
}
