import 'package:flutter/material.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import '../../resources/custom_widgets/msos_button.dart';
import '../../resources/custom_widgets/msos_text.dart';

/* Esta es la vista inicial, invocada cuando aún no se ha detectado una sesión
iniciada o se ha cerrado la sesión que estaba abierta */

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  @override
  Widget build(BuildContext context) {
    //Obtaining screen dimensions for easier to read code.
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false, //Used to not resize when keyboard appears
      body: Container(
          alignment: Alignment.topCenter,
          child: Stack(
            children: [
              ClipRect(
                child: Image.asset('lib/resources/assets/images/wizard_landscape.png', fit: BoxFit.cover),
              ),
              Column(
                children: [
//------------> This containar is used only to make dynamic the size that the image shows
                  Container(height: screenHeight * 0.15, decoration: const BoxDecoration()),
                  Expanded(
                      //Expanded allows his child to use all the avaliable space
                      child: Container(
                    width: screenWidth,
                    decoration: const BoxDecoration(
                        color: MSosColors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
// ---------------> This column could be seen as the actual content body of this view template
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(screenWidth * 0.15, 50, screenWidth * 0.15, 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const MSosText(
                            //Custom widget for predifined text style generation.
                            'Mantente segura',
                            style: MSosText.wizardTitleStyle,
                          ),
                          const MSosText(
                            'Cuida a tus seres queridos y permite que ellos cuiden de ti',
                            size: 18,
                            isMultiline: true,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const MSosButton(
                                text: 'Iniciar Sesión',
                                route: '/login',
                                style: MSosButton.continueLargeBtn,
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              const MSosText(
                                //Custom widget for predifined text style generation.
                                '¿Aún no tienes cuenta?',
                                style: MSosText.normalStyle,
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: MSosColors.transparent, fixedSize: Size(screenWidth * 0.6, 44)),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/signup');
                                },
                                child: const MSosText(
                                  //Custom widget for predifined text style generation.
                                  'Registrarse',
                                  style: MSosText.nudeStyle,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            ],
          )),
    );
  }
}
