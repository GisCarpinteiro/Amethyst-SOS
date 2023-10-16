import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

class MSosMultiOptionButton extends StatelessWidget {
  final String text;
  final Color color = MSosColors.white;
  final Color foregroundColor = MSosColors.grayMedium;
  final VoidCallback callbackFunction;
  final double width;

  const MSosMultiOptionButton({super.key, this.width = 120, required this.text, required this.callbackFunction});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: callbackFunction,
      style:
          TextButton.styleFrom(elevation: 2, shadowColor: MSosColors.grayLight, backgroundColor: color, foregroundColor: foregroundColor),
      child: SizedBox(
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: MSosText(
                text,
                isMultiline: false,
                textColor: foregroundColor,
                size: 14,
              ),
            ),
            const SizedBox(width: 4),
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
