import 'package:flutter/material.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import '../../resources/custom_widgets/msos_wizard_textbox.dart';
import '../../resources/custom_widgets/msos_text.dart';


/* Esta vista es la primera dos que sirve para la creación de una nueva cuenta
por medio del llenado de un formulario  */

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //Key used for the login formulary
  final _formKey = GlobalKey<FormState>();
  
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
                      color: MSosColors.white,
                      borderRadius: BorderRadius.circular(20)
                    ),
// ---------------> THIS COLUMN COULD BE SEEN AS THE ACTUAL CONTENT BODY OF THIS VIEW TEMPLATE
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        screenWidth * 0.12, 30, screenWidth * 0.12, 30
                      ),
                      child: Column( 
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const MSosText( //Custom widget for predifined text style generation.
                            'Registro', 
                            style: MSosText.wizardTitleStyle,
                          ),
                          FormCustomWidget(formKey: _formKey),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const MSosText( //Custom widget for predifined text style generation.
                                '¿Ya tienes una cuenta?', 
                                style: MSosText.normalStyle,
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: MSosColors.transparent,
                                  fixedSize: Size(screenWidth * 0.6, 44)
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/login'); 
                                },
                                child: const MSosText( //Custom widget for predifined text style generation.
                                  'Acceder', 
                                  style: MSosText.nudeStyle,
                                ),
                              ),
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

class FormCustomWidget extends StatelessWidget {
  const FormCustomWidget({
    super.key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Form(
            key: _formKey,
            child: const Column(
              children: [
                MSosWizardTextBox(
                  label: 'Nombre',
                  type: MSosWizardTextBox.normal,
                  icon: Icon(Icons.face_3_rounded, color: MSosColors.grayLight, size: 16,),
                ),
                SizedBox( height: 20,),
                MSosWizardTextBox(
                  label: 'Correo Electrónico',
                  placeholder: 'ejemplo@gmail.com',
                  type: MSosWizardTextBox.email,
                ),
                SizedBox( height: 20,),
                MSosWizardTextBox(
                  label: 'Contraseña',
                  placeholder: '*******',
                  type: MSosWizardTextBox.password,
                ),
                SizedBox( height: 20,),
                MSosWizardTextBox( //TODO: Create "passwordConfirmation" LabeledTextBoxCutimWidget Type and read "password" to compare with "passwordConfirmation" on submit or realtime.
                  label: 'Confirmar Contraseña',
                  placeholder: '*******',
                  type: MSosWizardTextBox.password,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor:MSosColors.pink,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()){
                      Navigator.pushNamed(context, '/signup2');
                    } else {ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Datos Inválidos'))
                      );
                    } // go to next screen
                  }, 
                  child: const MSosText(
                    "Siguiente",
                    textColor: MSosColors.white,
                    style: MSosText.buttonStyle,
                  )
                ),
              ),
            ]
          )
        ],
      ),
    );
  }
}




