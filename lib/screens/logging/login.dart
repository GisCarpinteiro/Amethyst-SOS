import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vistas_amatista/providers/login_provider.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_formfield.dart';
import '../../resources/custom_widgets/msos_text.dart';

/* Vista para ingresar a la cuenta por medio de correo/teléfono y contraseña o por medio 
de un servicio de autentificación (facebook, google, gmail) */

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  //Key used for the login formulary
  final _loginFormKey = GlobalKey<FormState>();
  //Form Controllers to access formfield values
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextFormField formField = TextFormField();

  @override
  Widget build(BuildContext context) {
    //Obtaining screen dimensions for easier to read code.
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final provider = context.read<LoginProvider>();

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
                          padding: EdgeInsets.fromLTRB(screenWidth * 0.12, 30, screenWidth * 0.12, 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const MSosText(
                                //Custom widget for predifined text style generation.
                                'Inicio de Sesión',
                                style: MSosText.wizardTitleStyle,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Form(
                                      key: _loginFormKey,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          MSosFormField(
                                              label: "email",
                                              controller: emailController,
                                              style: MSosFormFieldStyle.wizard,
                                              icon: FontAwesomeIcons.solidEnvelope),
                                          const SizedBox(height: 10),
                                          MSosFormField(
                                              label: "contraseña",
                                              controller: passwordController,
                                              validation: MSosFormFieldValidation.password,
                                              style: MSosFormFieldStyle.wizard,
                                              icon: FontAwesomeIcons.key)
                                        ],
                                      ),
                                    ),
                                    Row(children: [
                                      Expanded(
                                        child: TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: MSosColors.pink,
                                            ),
                                            onPressed: () {
                                              provider.logWithEmail(
                                                  email: emailController.text, password: passwordController.text);
                                            },
                                            child: const MSosText(
                                              "Iniciar Sesión",
                                              style: MSosText.buttonStyle,
                                              textColor: MSosColors.white,
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
                                    '¿Aún no tienes cuenta?',
                                    style: MSosText.normalStyle,
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: MSosColors.transparent,
                                        fixedSize: Size(screenWidth * 0.6, 44)),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/signup');
                                    },
                                    child: const MSosText(
                                      //Custom widget for predifined text style generation.
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
            )));
  }
}
