import 'package:flutter/material.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_button.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';
import 'package:google_fonts/google_fonts.dart';

/* Vista del wizard de configuración inicial para definir un mensaje personalizado
de emergencia (o hacer uso del mensaje por defecto si no se ingresa ninguno) */

class EmergencyMessageWizardScreen extends StatefulWidget {
  const EmergencyMessageWizardScreen({super.key});

  @override
  State<EmergencyMessageWizardScreen> createState() => _EmergencyMessageWizardScreenState();
}

class _EmergencyMessageWizardScreenState extends State<EmergencyMessageWizardScreen> {
  
  @override
  Widget build(BuildContext context) {

    //Obtaining screen dimensions for easier to read code.
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true, //Used to not resize when keyboard appears
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
                    height: screenHeight * 0.85,
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
                          const MSosText( //Custom widget for predifined text style generation.
                            'Mensaje de Alerta', 
                            style: MSosText.wizardTitleStyle,
                          ),
                          const MSosText(
                                'Define un mensaje personalizado que será enviado cuando una alerta sea activada a la par de otra información útil como tu ubicación',
                                style: MSosText.normalStyle,
                              ),
                          //TODO: Text Area for custom message.
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 6,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.fromLTRB(20, 20, 14, 6),
                              border: OutlineInputBorder(
                  //----------  >The border radius value could be more than needed to force "roundness"
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                  //----------  >The border radius value could be more than needed to force "roundness"
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                  color: MSosColors.blue,
                                  width: 2.0
                                )
                              ),
                              hintText: 'Hola, este mensaje es para informarte que me encuentro en una situación de riesgo y necesito de tu ayuda',
                              hintStyle: GoogleFonts.lexend(textStyle: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                  color: MSosColors.grayLight
                                )
                              )
                            ),
                          ),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MSosButton(text: 'Siguiente', route:'/trust_group_wizard', style: MSosButton.continueLargeBtn)
                            ],
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

