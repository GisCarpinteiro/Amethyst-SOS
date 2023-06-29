import 'package:flutter/material.dart';
import '../custom_widgets/btn_custom.dart';
import '../custom_widgets/text_custom.dart';

/* This class is the interface base/template that corresponds to the views of 
the LogIn, SignUp and Wizard, used by all of them for a cohesive UI */

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
    final double screenHeight = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false, //Used to not resize when keyboard appears
      body: Container(
        alignment: Alignment.topCenter,
        child: Stack(
          children: [
            ClipRect(
              child: Image.asset(
                'lib/assets/wizard_landscape.png',
                fit: BoxFit.cover
                ),
            ),
            Column(
              children: [
//------------> This containar is used only to make dynamic the size that the image shows
                Container(
                  height: screenHeight * 0.35,
                  decoration: const BoxDecoration(
                  )
                ),
                Expanded( //Expanded allows his child to use all the avaliable space
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                      screenWidth * 0.15, 
                      0,
                      screenWidth * 0.15,
                      0
                    ),
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(20)
                    ),
// ---------------> This column could be seen as the actual content body of this view template
                    child: Column( 
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const TextCustomWidget( //Custom widget for predifined text style generation.
                          'Mantente segura', 
                          style: TextCustomWidget.wizardTitleStyle,
                        ),
                        const TextCustomWidget(
                          'Cuida a tus seres queridos y permite que ellos cuiden de ti',
                          style: TextCustomWidget.normalStyle,
                        ),
                        const BtnCustomWidget(
                          text: 'Iniciar Sesión',
                          route: '/login',
                          style: BtnCustomWidget.continueLargeBtn,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const TextCustomWidget( //Custom widget for predifined text style generation.
                              '¿Aún no tienes cuenta?', 
                              style: TextCustomWidget.normalStyle,
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0x00000000),
                                fixedSize: Size(screenWidth * 0.6, 44)
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/signup'); 
                              }, 
                              child: const TextCustomWidget( //Custom widget for predifined text style generation.
                                'Registrarse', 
                                style: TextCustomWidget.nudeStyle,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                )
              ],
            ),
          ],
        )
      ),
    );
  }
}




