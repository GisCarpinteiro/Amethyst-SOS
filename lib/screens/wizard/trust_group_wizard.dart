import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistas_amatista/providers/group_provider.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_button.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

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

    final provider = context.read<GroupProvider>();

    return Scaffold(
      resizeToAvoidBottomInset: true, //Used to not resize when keyboard appears
      body: Container(
          alignment: Alignment.topCenter,
          child: Stack(
            children: [
              ClipRect(
                child: Image.asset('lib/resources/assets/images/wizard_landscape.png', fit: BoxFit.cover),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    //------------> This containar is used only to make dynamic the size that the image shows
                    Container(height: screenHeight * 0.15, decoration: const BoxDecoration()),
                    Container(
                      height: screenHeight * 0.85,
                      width: screenWidth,
                      decoration: BoxDecoration(color: MSosColors.white, borderRadius: BorderRadius.circular(20)),
                      // ---------------> This column could be seen as the actual content body of this view template
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(screenWidth * 0.12, 30, screenWidth * 0.12, 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const MSosText(
                              //Custom widget for predifined text style generation.
                              'Grupos de Confianza',
                              style: MSosText.wizardTitleStyle,
                            ),
                            ClipRect(
                              child: Image.asset('lib/resources/assets/images/trust_group.png', fit: BoxFit.cover),
                            ),
                            const MSosText(
                              'Puedes agregar varios contactos a un grupo de confianza para notificarlos de forma simultánea cuando actives una alerta',
                              style: MSosText.normalStyle,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //TODO: Redirigir a la vista de configuración de grupos de confianza cuándo esté implementado
                                MSosButton(
                                  text: 'Crear Grupo',
                                  style: MSosButton.continueLargeBtn,
                                  onPressed: () => provider.newGroupContext(context),
                                )
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
          )),
    );
  }
}
