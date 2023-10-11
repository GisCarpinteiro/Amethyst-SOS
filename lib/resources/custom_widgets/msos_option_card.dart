import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

class MSosOptionCard extends StatelessWidget {
  final String title;
  final VoidCallback? callback;
  final String? cardDescription;
  final IconData? cardIcon;
  final bool isSelected;

  const MSosOptionCard({super.key, required this.title, this.cardDescription, this.cardIcon, this.callback, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          elevation: 2,
          foregroundColor: MSosColors.grayDark,
          backgroundColor: MSosColors.white,
          shadowColor: MSosColors.grayLight,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      onPressed: callback,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        MSosText(title),
        if (isSelected) FaIcon(FontAwesomeIcons.circleCheck, color: isSelected ? MSosColors.pink : MSosColors.grayLight),
      ]),
    );
  }
}
