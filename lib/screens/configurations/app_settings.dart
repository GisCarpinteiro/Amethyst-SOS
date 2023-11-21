import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistas_amatista/providers/app_settings_provider.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_appbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_dashboard.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_formfield.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_pop_up_menu.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

class AppSettingsScreen extends StatelessWidget {
  const AppSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final passwdForm = GlobalKey<FormState>();
    final provider = context.read<AppSettingsProvider>();
    final state = context.watch<AppSettingsProvider>();

    late final MSosPopUpMenu changePasswdPopUp;
    changePasswdPopUp = MSosPopUpMenu(context,
        formKey: passwdForm,
        title: "Cambiar Contraseña",
        formChildren: [
          MSosFormField(controller: state.currentPasswordCtlr, label: "Contraseña Actual"),
          const SizedBox(height: 10),
          MSosFormField(controller: state.newPasswordCtlr, label: "Nueva Contraseña"),
          const SizedBox(height: 10),
          MSosFormField(controller: state.confirmPasswordCtlr, label: "Confirma la nueva contraseña")
        ],
        cancelCallbackFunc: () {},
        acceptCallbackFunc: () {});

    return Scaffold(
      resizeToAvoidBottomInset: true, //Used to not resize when keyboard appears
      appBar: const MSosAppBar(title: "Configuración General", icon: Icons.settings),
      drawer: const MSosDashboard(),
      body: Container(
          alignment: Alignment.topLeft,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.fromLTRB(screenWidth * 0.08, 0, screenWidth * 0.08, 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MSosText("Cuenta", style: MSosText.subtitleStyle),
                        const Divider(),
                        MSosFormField(controller: state.usernameCtlr, label: "Nombre de Usuario"),
                        const SizedBox(height: 10),
                        MSosFormField(controller: state.phoneCtlr, label: "Phone"),
                        const SizedBox(height: 10),
                        MSosFormField(controller: state.emailCtlr, label: "email"),
                        const SizedBox(height: 15),
                        TextButton(
                          onPressed: () {
                            changePasswdPopUp.showPopUpMenu(context);
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: MSosColors.blue,
                              shadowColor: MSosColors.grayDark,
                              elevation: 2,
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                          child: const MSosText(
                            "Cambiar Contraseña",
                            textColor: MSosColors.white,
                          ),
                        ),
                        const SizedBox(height: 30),
                        const MSosText(
                          "Apariencia",
                          style: MSosText.subtitleStyle,
                        ),
                        const Divider(),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const MSosText("Modo Oscuro"),
                            CupertinoSwitch(
                                value: state.darkTheme,
                                activeColor: MSosColors.blue,
                                onChanged: (value) {
                                  provider.changeDarkTheme(value);
                                }),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const MSosText("Mostrar Mapa en Inicio"),
                            CupertinoSwitch(
                                value: state.mapOnHome,
                                activeColor: MSosColors.blue,
                                onChanged: (value) {
                                  provider.changeMapOnHome(value);
                                }),
                          ],
                        ),
                      ]),
                ],
              ),
            ),
          )),
    );
  }
}
