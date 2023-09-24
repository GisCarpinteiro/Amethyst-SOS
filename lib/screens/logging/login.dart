import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistas_amatista/blocs/login_blocs/login_bloc/login_bloc.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import '../../resources/custom_widgets/msos_wizard_textbox.dart';
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Obtaining screen dimensions for easier to read code.
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true, //Used to not resize when keyboard appears
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Container(
              alignment: Alignment.topCenter,
              child: Stack(
                children: [
                  ClipRect(
                    child: Image.asset('lib/assets/wizard_landscape.png', fit: BoxFit.cover),
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
                                        key: _formKey,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const MSosText("Email"),
                                            TextField(
                                              key: const Key("email"),
                                              controller: emailController,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const MSosText("Contraseña"),
                                            TextField(key: const Key("password"), controller: passwordController)
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
                                                BlocProvider.of<LoginBloc>(context).add(GetUserAndPassword(
                                                    email: emailController.text, password: passwordController.text, context: context));
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
                                ClipRect(
                                  child: Image.asset('lib/assets/auth_services.png', fit: BoxFit.cover),
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
                                          backgroundColor: MSosColors.transparent, fixedSize: Size(screenWidth * 0.6, 44)),
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
              ));
        },
      ),
    );
  }
}
