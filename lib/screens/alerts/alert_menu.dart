import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vistas_amatista/blocs/alert_blocs/alert_menu/alert_menu_bloc.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_appbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_button.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_formfield.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

/* Vista de configuración para el disparador/activador de alerta provocado
por una desconexión a internet.*/

class AlertMenuScreen extends StatefulWidget {
  const AlertMenuScreen({super.key});

  @override
  State<AlertMenuScreen> createState() => _AlertMenuScreenState();
}

class _AlertMenuScreenState extends State<AlertMenuScreen> {
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

    return BlocBuilder<AlertMenuBloc, AlertMenuState>(
      builder: (context, state) {
        // We read if either is the Edition Screen or the Creation Screen
        bool isEdition = state.isAlertEditionContext;
        // Inicialization of some variables for widgets that need re renderization to work
        toleranceTimeOption = toleranceTimeOption ?? (isEdition ? getOptionFromValue(state.alert!.toleranceTime) : 0);
        shareLocationEnabled = shareLocationEnabled ?? (isEdition ? state.alert!.shareLocation : false);
        triggers = (triggers ?? (isEdition ? state.alert!.triggers : defaultTriggerConfig)) as Map<String, dynamic>;

        return Scaffold(
          resizeToAvoidBottomInset: true, //Used to not resize when keyboard appears
          appBar: MSosAppBar(title: isEdition ? "Editar Alerta" : "Crear Alerta", icon: Icons.crisis_alert),
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
                            isEdition ? state.alert!.name : "Crear Alerta",
                            style: MSosText.subtitleStyle,
                            icon: Icons.add_circle_rounded,
                          ),
                          const SizedBox(height: 20),
                          Form(
                            key: _formKey,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              const MSosText("Nombre de la Alerta"),
                              MSosFormField(
                                initialValue: isEdition ? state.alert!.name : "Nueva Alerta",
                              ),
                              const SizedBox(height: 10),
                              const MSosText("Mensaje de Auxilio"),
                              MSosFormField(
                                initialValue:
                                    isEdition ? state.alert!.message : "Me encuentro en una situación de peligro y necesito de tu ayuda",
                              ),
                              const SizedBox(height: 10),
                              const MSosText("Tiempo de tolerancia"),
                              const SizedBox(height: 4),
                              CupertinoSlidingSegmentedControl<int>(
                                  thumbColor: MSosColors.blue,
                                  groupValue: toleranceTimeOption,
                                  children: {
                                    0: MSosText(
                                      '10s',
                                      style: MSosText.normalStyle,
                                      textColor: toleranceTimeOption != 0 ? null : MSosColors.white,
                                    ),
                                    1: MSosText('30s',
                                        style: MSosText.normalStyle, textColor: toleranceTimeOption != 1 ? null : MSosColors.white),
                                    2: MSosText('60s',
                                        style: MSosText.normalStyle, textColor: toleranceTimeOption != 2 ? null : MSosColors.white),
                                    3: MSosText('120s',
                                        style: MSosText.normalStyle, textColor: toleranceTimeOption != 3 ? null : MSosColors.white),
                                    4: MSosText('300s',
                                        style: MSosText.normalStyle, textColor: toleranceTimeOption != 4 ? null : MSosColors.white)
                                  },
                                  onValueChanged: (groupValue) {
                                    // In this case we don't need to update the bloc state until the save button is pressed
                                    setState(() {
                                      toleranceTimeOption = groupValue ?? 0;
                                    });
                                  }),
                              const SizedBox(height: 20),
                              const MSosText("Compartir ubicación al habilitar"),
                              const SizedBox(height: 2),
                              CupertinoSwitch(
                                  value: shareLocationEnabled!,
                                  activeColor: MSosColors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      shareLocationEnabled = value;
                                    });
                                  }),
                              const SizedBox(height: 20),
                              const MSosText("Activadores de la alerta"),
                              const SizedBox(height: 10),
                              // Trigger Switch Grid
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        width: screenWidth * 0.20,
                                        child: Column(
                                          children: [
                                            IconButton.filled(
                                                onPressed: () {
                                                  setState(() {
                                                    triggers!['button_trigger'] = !triggers!['button_trigger'];
                                                  });
                                                },
                                                style: IconButton.styleFrom(
                                                    backgroundColor: triggers!['button_trigger'] ? MSosColors.blue : MSosColors.grayLight),
                                                icon: const FaIcon(
                                                  FontAwesomeIcons.mobileButton,
                                                  color: MSosColors.white,
                                                )),
                                            const MSosText(
                                              "desde aplicación",
                                              size: 12,
                                              isCentered: true,
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.20,
                                        child: Column(
                                          children: [
                                            IconButton.filled(
                                                onPressed: () {
                                                  setState(() {
                                                    triggers!['smartwatch_trigger'] = !triggers!['smartwatch_trigger'];
                                                  });
                                                },
                                                style: IconButton.styleFrom(
                                                    backgroundColor:
                                                        triggers!['smartwatch_trigger'] ? MSosColors.blue : MSosColors.grayLight),
                                                icon: const Icon(
                                                  Icons.watch_rounded,
                                                  color: MSosColors.white,
                                                )),
                                            const MSosText(
                                              'desde smartwatch',
                                              size: 12,
                                              isCentered: true,
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.20,
                                        child: Column(
                                          children: [
                                            IconButton.filled(
                                                onPressed: () {
                                                  setState(() {
                                                    triggers!['disconnection_trigger'] = !triggers!['disconnection_trigger'];
                                                  });
                                                },
                                                style: IconButton.styleFrom(
                                                    backgroundColor:
                                                        triggers!['disconnection_trigger'] ? MSosColors.blue : MSosColors.grayLight),
                                                icon: const FaIcon(
                                                  FontAwesomeIcons.towerCell,
                                                  color: MSosColors.white,
                                                  size: 18,
                                                )),
                                            const MSosText(
                                              'desconexión con la red',
                                              size: 12,
                                              isCentered: true,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        width: screenWidth * 0.20,
                                        child: Column(
                                          children: [
                                            IconButton.filled(
                                                onPressed: () {
                                                  setState(() {
                                                    triggers!['smartwatch_disconnection_trigger'] =
                                                        !triggers!['smartwatch_disconnection_trigger'];
                                                  });
                                                },
                                                style: IconButton.styleFrom(
                                                    backgroundColor: triggers!['smartwatch_disconnection_trigger']
                                                        ? MSosColors.blue
                                                        : MSosColors.grayLight),
                                                icon: const Icon(
                                                  Icons.watch_off,
                                                  color: MSosColors.white,
                                                )),
                                            const MSosText(
                                              'desconexión smartwatch',
                                              size: 12,
                                              isCentered: true,
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.20,
                                        child: Column(
                                          children: [
                                            IconButton.filled(
                                                onPressed: () {
                                                  setState(() {
                                                    triggers!['voice_trigger'] = !triggers!['voice_trigger'];
                                                  });
                                                },
                                                style: IconButton.styleFrom(
                                                    backgroundColor: triggers!['voice_trigger'] ? MSosColors.blue : MSosColors.grayLight),
                                                icon: const FaIcon(
                                                  FontAwesomeIcons.microphone,
                                                  color: MSosColors.white,
                                                )),
                                            const MSosText(
                                              'activación por voz',
                                              size: 12,
                                              isCentered: true,
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.20,
                                        child: Column(
                                          children: [
                                            IconButton.filled(
                                                onPressed: () {
                                                  setState(() {
                                                    triggers!['backtap_trigger'] = !triggers!['backtap_trigger'];
                                                  });
                                                },
                                                style: IconButton.styleFrom(
                                                    backgroundColor: triggers!['backtap_trigger'] ? MSosColors.blue : MSosColors.grayLight),
                                                icon: const FaIcon(
                                                  FontAwesomeIcons.solidHandPointUp,
                                                  size: 20,
                                                  color: MSosColors.white,
                                                )),
                                            const MSosText(
                                              'sensor backtap',
                                              size: 12,
                                              isCentered: true,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              MSosButton(
                                text: isEdition ? "Guardar" : "Crear",
                                style: MSosButton.smallButton,
                                color: MSosColors.blue,
                                callbackFunction: () {
                                  // We Build The Aler Item on Creation.
                                  if (isEdition){
                                    
                                  } else {  // We update the values for the alert with the same ID

                                  }
                                },
                              )
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

  // Get Option From Alert.ToleranceTime state
  int? getOptionFromValue(int? value) {
    switch (value) {
      case 10:
        return 0;
      case 30:
        return 1;
      case 60:
        return 2;
      case 120:
        return 3;
      case 300:
        return 4;
      default:
        return null;
    }
  }
}
