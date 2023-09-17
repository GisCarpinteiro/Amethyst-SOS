import 'package:flutter/material.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_button.dart';
import '../resources/custom_widgets/msos_text.dart';

/* Esta vista es temporal, usada para probar las funcionalidades del proyecto por separado de 
forma independiente. Está hecha con el propósito de testear funcionalidades más fácilmente sin 
necesidad de tener que configurar un perfil desde 0 o depender de otras funciones/vistas para 
poder acceder a ellas.*/

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  @override
  Widget build(BuildContext context) {
    //Obtaining screen dimensions for easier to read code.
    final double screenWidth = MediaQuery.of(context).size.width;
    //final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true, //Used to not resize when keyboard appears
      body: Container(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.fromLTRB(screenWidth * 0.12, 50, screenWidth * 0.12, 50),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MSosText(
                    "Test/Demo Screen!",
                    style: MSosText.sectionTitleStyle,
                    icon: Icons.construction_outlined,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MSosButton(
                    text: "Wizard",
                    route: '/startup',
                    style: MSosButton.continueLargeBtn,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MSosButton(text: "Trigger Settings", route: '/trigger_settings', style: MSosButton.continueLargeBtn),
                  SizedBox(
                    height: 20,
                  ),
                  MSosButton(text: "Home", route: '/home', style: MSosButton.continueLargeBtn),
                  SizedBox(
                    height: 20,
                  ),
                  MSosButton(text: "Alert List", route: '/alert_list', style: MSosButton.continueLargeBtn),
                  SizedBox(
                    height: 20,
                  ),
                  MSosButton(text: "Group List", route: '/group_list', style: MSosButton.continueLargeBtn),
                ],
              ),
            ),
          )),
    );
  }
}
