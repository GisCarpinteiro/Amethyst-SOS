import 'package:flutter/material.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({Key? key}) : super(key: key);

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
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /*IconButton(
                    icon: Image.asset('assets/icons/alert_list_icon.png'), 
                    onPressed: () {  },
                  ),*/
              SizedBox(height: 4),
              Text('Alerts'),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /*IconButton(
                    icon: Image.asset('assets/icons/group_icon.png'),
                    onPressed: () {},
                    tooltip: 'Alarm',
                  ),*/
              SizedBox(height: 4),
              Text('Groups'),
            ],
          ),
        ],
      ),
    );
  }
}
