import 'package:flutter/material.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import '../../resources/custom_widgets/msos_button.dart';
import '../../resources/custom_widgets/msos_text.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

/* Vista para la confirmación de el email/teléfono por medio de un código enviado por correo
o mensaje SMS que deberá ser ingresado para poder crear una cuenta*/

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
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false, //Used to not resize when keyboard appears
      body: Container(
        alignment: Alignment.topCenter,
        child: Stack(
          children: [
            ClipRect(
              child: Image.asset(
                'lib/resources/assets/images/wizard_landscape.png',
                fit: BoxFit.cover
                ),
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  //------------> This containar is used only to make dynamic the size that the image shows
                  Container(
                    height: screenHeight * 0.15,
                    decoration: const BoxDecoration(
                    )
                  ),
                  Container(
                    height: screenHeight* 0.85,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: MSosColors.white,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    // ---------------> This column could be seen as the actual content body of this view template
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        screenWidth * 0.12, 30, screenWidth * 0.12, 50
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column( 
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const MSosText( //Custom widget for predifined text style generation.
                                'Verifica tu correo electrónico', 
                                style: MSosText.wizardTitleStyle,
                              ),
                              const SizedBox(height: 30),
                              const MSosText(
                                'Intruduce el pin de verificación que hemos enviado al correo que registraste',
                                style: MSosText.normalStyle,
                              ),
                              const SizedBox(height: 30),
                              VerificationCode(
                                onCompleted: (String value){
                                },
                                onEditing: (bool value){}
                              ),
                              
                            ],
                          ),
                          const MSosButton(
                                text: 'Verificar',
                                route: '/emergency_message_wizard',
                                style: MSosButton.continueLargeBtn,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}




