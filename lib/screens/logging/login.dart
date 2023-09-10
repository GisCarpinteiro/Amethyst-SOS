import 'package:flutter/material.dart';
import '../../custom_widgets/msos_wizard_textbox.dart';
import '../../custom_widgets/msos_text.dart';


/* Vista para ingresar a la cuenta por medio de correo/teléfono y contraseña o por medio 
de un servicio de autentificación (facebook, google, gmail) */

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
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
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    // ---------------> This column could be seen as the actual content body of this view template
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        screenWidth * 0.12, 30, screenWidth * 0.12, 30
                      ),
                      child: Column( 
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const MSosText( //Custom widget for predifined text style generation.
                            'Inicio de Sesión', 
                            style: MSosText.wizardTitleStyle,
                          ),
                          FormCustomWidget(formKey: _formKey),
                          ClipRect(
                            child: Image.asset(
                              'lib/assets/auth_services.png',
                              fit: BoxFit.cover
                              ),
                          ),
                                  
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const MSosText( //Custom widget for predifined text style generation.
                                '¿Aún no tienes cuenta?', 
                                style: MSosText.normalStyle,
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(0x00000000),
                                  fixedSize: Size(screenWidth * 0.6, 44)
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/signup'); 
                                },
                                child: const MSosText( //Custom widget for predifined text style generation.
                                  'Registrarse', 
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


//Maybe this class could be reusable
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
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor:const Color(0xFFEF8496),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()){
                      Navigator.pushNamed(context, '/not_found');
                    } else {ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Datos Inválidos'))
                        );
                    } // go to next screen
                  }, 
                  child: const MSosText(
                    "Iniciar Sesión",
                    style: MSosText.buttonStyle,
                    textColor: Color(0xFFFFFFFF),
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




