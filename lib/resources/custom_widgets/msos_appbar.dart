import 'package:flutter/material.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

class MSosAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MSosAppBar({super.key, this.title = '', this.icon});

  final String title;

  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: MSosColors.grayDark, opticalSize: CircularProgressIndicator.strokeAlignOutside),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MSosText(
            title,
            style: MSosText.sectionTitleStyle,
            icon: icon,
            size: title.length > 16 ? (title.length > 18 ? 16 : 20) : null,
            iconSize: 20,
          ),
          const SizedBox(
            width: 0,
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 60);
}
