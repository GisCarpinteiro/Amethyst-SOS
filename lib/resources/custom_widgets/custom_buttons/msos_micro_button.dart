import 'package:flutter/material.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

class MSosMicroButton extends StatelessWidget {
  final Color backgroundActiveColor;
  final String text;
  final Color backgroundInactiveColor;
  final Color borderColor;
  final Color textColor;
  final double height;
  final double textSize;
  final VoidCallback? callback;
  final bool isActive;

  const MSosMicroButton({
    super.key,
    this.backgroundActiveColor = MSosColors.blue,
    this.text = "Lorem Ipsum",
    this.backgroundInactiveColor = MSosColors.white,
    this.borderColor = MSosColors.blueDark,
    this.textColor = MSosColors.white,
    this.height = 24,
    this.textSize = 12,
    this.callback,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: callback,
      color: isActive ? backgroundActiveColor : backgroundInactiveColor,
      height: height,
      shape: RoundedRectangleBorder(side: BorderSide(color: borderColor, width: 2), borderRadius: const BorderRadius.all(Radius.circular(20))),
      elevation: 0,
      child: MSosText(
        text,
        textColor: textColor,
        size: textSize,
      ),
    );
  }
}
