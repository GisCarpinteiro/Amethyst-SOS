import 'package:flutter/material.dart';
import 'package:vistas_amatista/custom_widgets/btn_custom.dart';
import 'package:vistas_amatista/custom_widgets/text_custom.dart';
import 'package:google_fonts/google_fonts.dart';

/* Vista del wizard de configuración inicial para definir un mensaje personalizado
de emergencia (o hacer uso del mensaje por defecto si no se ingresa ninguno) */

class CreateTrustGroupWizardScreen extends StatefulWidget {
  const CreateTrustGroupWizardScreen({super.key});

  @override
  State<CreateTrustGroupWizardScreen> createState() => _CreateTrustGroupWizardScreenState();
}

class _CreateTrustGroupWizardScreenState extends State<CreateTrustGroupWizardScreen> {
  
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
                'lib/assets/wizard_landscape.png',
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
                        children: [
                          const TextCustomWidget( //Custom widget for predifined text style generation.
                            'Grupos de Confianza', 
                            style: TextCustomWidget.wizardTitleStyle,
                          ),
                          ClipRect(
                            child: Image.asset(
                              'lib/assets/trust_group.png',
                              fit: BoxFit.cover
                              ),
                          ),
                          const TextCustomWidget(
                                'Puedes agregar varios contactos a un grupo de confianza para notificarlos de forma simultánea cuando actives una alerta',
                                style: TextCustomWidget.normalStyle,
                              ),
                          
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //TODO: Redirigir a la vista de configuración de grupos de confianza cuándo esté implementado
                              BtnCustomWidget(text: 'Crear Grupo', route:'/not_found', style: BtnCustomWidget.continueLargeBtn)
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

