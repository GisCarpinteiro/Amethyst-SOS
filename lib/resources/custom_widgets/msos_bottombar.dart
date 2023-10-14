import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

class CustomBottomAppBar extends StatelessWidget {
  final bool isFromAlertScreen;
  final bool isFromGroupScreen;

  const CustomBottomAppBar({Key? key, this.isFromAlertScreen = false, this.isFromGroupScreen = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var automaticNotchedShape = const AutomaticNotchedShape(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(70)),
      ),
    );

    return BottomAppBar(
      color: MSosColors.secondaryColor,
      // this creates a notch in the center of the bottom bar
      notchMargin: 10,
      // ignore: prefer_const_constructors
      shape: automaticNotchedShape,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: IconButton(
                  icon: isFromAlertScreen
                      ? const FaIcon(
                          FontAwesomeIcons.house,
                          color: MSosColors.white,
                          size: 18,
                        )
                      : Image.asset(
                          'lib/resources/assets/images/alert_list_icon.png',
                        ),
                  onPressed: () {},
                  iconSize: 24,
                ),
              ),
              MSosText(isFromAlertScreen ? 'Home' : 'Alertas', textColor: MSosColors.white),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: IconButton(
                  icon: isFromGroupScreen
                      ? const FaIcon(FontAwesomeIcons.house)
                      : Image.asset('lib/resources/assets/images/group_icon.png', fit: BoxFit.fitHeight),
                  onPressed: () {},
                  tooltip: 'Alarm',
                  iconSize: 30,
                ),
              ),
              MSosText(isFromGroupScreen ? 'Home' : 'Grupos', textColor: MSosColors.white),
            ],
          ),
        ],
      ),
    );
  }
}
