import 'package:flutter/material.dart';
import '../custom_widgets/btn_custom.dart';
import '../custom_widgets/text_custom.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

/* This class is the interface base/template that corresponds to the views of 
the LogIn, SignUp and Wizard, used by all of them for a cohesive UI */

class ConfirmEmailScreen extends StatefulWidget {
  const ConfirmEmailScreen({super.key});

  @override
  State<ConfirmEmailScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<ConfirmEmailScreen> {
  

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
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(20)
                    ),
// ---------------> This column could be seen as the actual content body of this view template
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        screenWidth * 0.12, 30, screenWidth * 0.12, 50
                      ),
                      child: Column( 
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const TextCustomWidget( //Custom widget for predifined text style generation.
                            'Verifica tu correo electrónico', 
                            style: TextCustomWidget.wizardTitleStyle,
                          ),
                          const TextCustomWidget(
                            'Intruduce el pin de verificación que hemos enviado al correo que registraste',
                            style: TextCustomWidget.normalStyle,
                          ),
                          VerificationCode(
                            onCompleted: (String value){
                            },
                            onEditing: (bool value){}
                          ),
                          const BtnCustomWidget(
                            text: 'Verificar',
                            route: '/not_found',
                            style: BtnCustomWidget.continueLargeBtn,
                          ),
                        ],
                      ),
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




