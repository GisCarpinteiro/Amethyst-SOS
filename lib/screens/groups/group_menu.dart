import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vistas_amatista/blocs/alert_blocs/alert_menu/alert_menu_bloc.dart';
import 'package:vistas_amatista/blocs/group_blocs/group_menu/group_menu_bloc.dart';
import 'package:vistas_amatista/models/group.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_appbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_button.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_formfield.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

/* Vista de configuración para el disparador/activador de alerta provocado
por una desconexión a internet.*/

class GroupMenuScreen extends StatefulWidget {
  const GroupMenuScreen({super.key});

  @override
  State<GroupMenuScreen> createState() => _GroupMenuScreenState();
}

class _GroupMenuScreenState extends State<GroupMenuScreen> {
  //Key used for the login formulary
  final _formKey = GlobalKey<FormState>();
  // Utility Variables to Build the status
  int? toleranceTimeOption;
  bool? shareLocationEnabled;
  Map? triggers;

  Map<String, bool> defaultTriggerConfig = {
    'button_trigger': true,
    'backtap_trigger': false,
    'voice_trigger': false,
    'smartwatch_trigger': false,
    'smartwatch_disconnection_trigger': false,
    'disconnection_trigger': true
  };

  @override
  Widget build(BuildContext context) {
    //Obtaining screen dimensions for easier to read code.
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height - 60;

    return BlocBuilder<GroupMenuBloc, GroupMenuState>(
      builder: (context, state) {
        // We read if either is the Edition Screen or the Creation Screen
        bool isEdition = state.isGroupEditionContext;
        // Inicialization of some variables for widgets that need re renderization to work

        return Scaffold(
          resizeToAvoidBottomInset: true, //Used to not resize when keyboard appears
          appBar: MSosAppBar(title: isEdition ? "Editar Grupo" : "Crear Grupo", icon: Icons.crisis_alert),
          body: Container(
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                  height: screenHeight,
                  width: screenWidth,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(screenWidth * 0.08, 0, screenWidth * 0.08, 60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                          MSosText(
                            isEdition ? state.group!.name : "Nuevo Grupo",
                            style: MSosText.subtitleStyle,
                            icon: Icons.add_circle_rounded,
                          ),
                          const SizedBox(height: 20),
                          Form(
                            key: _formKey,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              const MSosText("Nombre del Grupo"),
                              MSosFormField(initialValue: isEdition ? state.group!.name : "Nuevo Grupo"),
                              const SizedBox(height: 10),
                              const MSosText("Lista de contactos"),
                              const SizedBox(height: 10),
                              const MSosText(
                                "Bajo Construcción! 👷",
                                textColor: Colors.red,
                              ),
                            ]),
                          )
                        ]),
                      ],
                    ),
                  ),
                ),
              )),
        );
      },
    );
  }
}
