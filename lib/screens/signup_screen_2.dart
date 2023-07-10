import 'package:flutter/material.dart';
import 'package:vistas_amatista/custom_widgets/btn_custom.dart';
import '../custom_widgets/labeled_textbox_custom.dart';
import '../custom_widgets/text_custom.dart';


/* This class is the interface base/template that corresponds to the views of 
the LogIn, SignUp and Wizard, used by all of them for a cohesive UI */

class SignUpScreen2 extends StatefulWidget {
  const SignUpScreen2({super.key});

  @override
  State<SignUpScreen2> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<SignUpScreen2> {
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
// ---------------> THIS COLUMN COULD BE SEEN AS THE ACTUAL CONTENT BODY OF THIS VIEW TEMPLATE
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        screenWidth * 0.12 , 30, screenWidth * 0.12, 30
                      ),
                      child: Column( 
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextCustomWidget( //Custom widget for predifined text style generation.
                            'Registro', 
                            style: TextCustomWidget.wizardTitleStyle,
                          ),
                          Form(
                            key: _formKey,
                            child: const Column(
                              children: [
                                LabeledTextBoxCustomWidget(
                                  label: 'Teléfono',
                                  type: LabeledTextBoxCustomWidget.normal,
                                  icon: Icon(Icons.face_3_rounded, color: Color(0xFF999999), size: 16,),
                                ),
                                SizedBox( height: 20,),
                                LabeledTextBoxCustomWidget(
                                  label: 'Género',
                                  placeholder: 'Femenino',
                                  type: LabeledTextBoxCustomWidget.normal,
                                ),
                                SizedBox( height: 20,),
                                LabeledTextBoxCustomWidget(
                                  label: 'Fecha de Nacimiento',
                                  placeholder: '01/01/2000',
                                  type: LabeledTextBoxCustomWidget.normal,
                                ),
                                SizedBox( height: 20,),
                                LabeledTextBoxCustomWidget(
                                  label: 'País',
                                  placeholder: 'México',
                                  type: LabeledTextBoxCustomWidget.normal,
                                ),
                              ],
                            ),
                          ),
                          const BtnCustomWidget(text: 'Siguiente', route: '/confirm_email', style: BtnCustomWidget.continueLargeBtn),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const TextCustomWidget( //Custom widget for predifined text style generation.
                                '¿Ya tienes una cuenta?', 
                                style: TextCustomWidget.normalStyle,
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(0x00000000),
                                  fixedSize: Size(screenWidth * 0.6, 44)
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/login'); 
                                }, 
                                child: const TextCustomWidget( //Custom widget for predifined text style generation.
                                  'Acceder', 
                                  style: TextCustomWidget.nudeStyle,
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




