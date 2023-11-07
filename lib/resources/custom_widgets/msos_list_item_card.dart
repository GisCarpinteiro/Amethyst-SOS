import 'package:flutter/material.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

class MSosListItemCard extends StatelessWidget {
  final String title;
  final VoidCallback? callback;
  final VoidCallback? deleteCallback;
  final String? cardDescription;
  final IconData? cardIcon;

  const MSosListItemCard({super.key, required this.title, this.cardDescription, this.cardIcon, this.callback, this.deleteCallback});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          elevation: 4,
          foregroundColor: MSosColors.grayDark,
          backgroundColor: MSosColors.white,
          shadowColor: MSosColors.grayLight,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      onPressed: callback,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        MSosText(title),
        if (deleteCallback!= null) IconButton(
          color: MSosColors.grayMedium,
          visualDensity: VisualDensity.compact,
          onPressed: deleteCallback,
          icon: const Icon(Icons.delete),
          iconSize: 18,
        )
      ]),
    );
  }
}
