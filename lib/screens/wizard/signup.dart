import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vistas_amatista/providers/signup_provider.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_formfield.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_snackbar.dart';
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
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Obtaining screen dimensions for easier to read code.
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    SignUpProvider provider = context.watch<SignUpProvider>();

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
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(screenWidth * 0.12, 30, screenWidth * 0.12, 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const MSosText(
                              //Custom widget for predifined text style generation.
                              'Registro',
                              style: MSosText.wizardTitleStyle,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  // ---------------> Login Formulary
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        MSosFormField(
                                            label: 'Nombre',
                                            controller: nameController,
                                            style: MSosFormFieldStyle.wizard,
                                            icon: FontAwesomeIcons.idCard),
                                        const SizedBox(height: 10),
                                        MSosFormField(
                                          label: 'Correo Electrónico',
                                          controller: emailController,
                                          style: MSosFormFieldStyle.wizard,
                                          icon: FontAwesomeIcons.solidEnvelope,
                                          validation: MSosFormFieldValidation.email,
                                        ),
                                        const SizedBox(height: 10),
                                        MSosFormField(
                                          label: 'Contraseña',
                                          controller: passwordController,
                                          style: MSosFormFieldStyle.wizard,
                                          icon: FontAwesomeIcons.lock,
                                          validation: MSosFormFieldValidation.password,
                                        ),
                                        const SizedBox(height: 10),
                                        MSosFormField(
                                            label: 'Confirmar Contraseña',
                                            controller: confirmPasswordController,
                                            style: MSosFormFieldStyle.wizard,
                                            icon: FontAwesomeIcons.lock,
                                            validation: MSosFormFieldValidation.password),
                                      ],
                                    ),
                                  ),
                                  // TODO: Mejorar a botón Custom
                                  Row(children: [
                                    Expanded(
                                      child: TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: MSosColors.pink,
                                          ),
                                          onPressed: () {
                                            if (_formKey.currentState!.validate()) {
                                              if (passwordController.text == confirmPasswordController.text) {
                                                provider.valuesFromFirstForm(
                                                    name: nameController.text,
                                                    email: emailController.text,
                                                    password: passwordController.text);
                                                Navigator.pushNamed(context, '/signup2');
                                              } else {
                                                MSosFloatingMessage.showMessage(context,
                                                    message: "La contraseña no coincide con su confirmación!");
                                              }
                                            } else {
                                              MSosFloatingMessage.showMessage(context,
                                                  message: "Datos no válidos", type: MSosMessageType.error);
                                            } // go to next screen
                                          },
                                          child: const MSosText(
                                            "Siguiente",
                                            textColor: MSosColors.white,
                                            style: MSosText.buttonStyle,
                                          )),
                                    ),
                                  ])
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const MSosText(
                                  //Custom widget for predifined text style generation.
                                  '¿Ya tienes una cuenta?',
                                  style: MSosText.normalStyle,
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: MSosColors.transparent, fixedSize: Size(screenWidth * 0.6, 44)),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                                  child: const MSosText(
                                    //Custom widget for predifined text style generation.
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
          )),
    );
  }
}
