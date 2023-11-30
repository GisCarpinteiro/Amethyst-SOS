import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vistas_amatista/providers/alert_provider.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_appbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_bottombar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_button.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_dashboard.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_floating_alert_button.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_formfield.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_snackbar.dart';
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
  // FormField Controllers:

  // Utility Variables to Build the status

  @override
  Widget build(BuildContext context) {
    //Obtaining screen dimensions for easier to read code.
    final double screenWidth = MediaQuery.of(context).size.width;

    final state = context.watch<AlertProvider>();
    final provider = context.read<AlertProvider>();

    // We read if either is the Edition Screen or the Creation Screen
    bool isEdition = state.isAlertEditionContext;
    // Initialize some values if is an edition of an existing alert or the creation of a new one

    return Scaffold(
      resizeToAvoidBottomInset: true, //Used to not resize when keyboard appears
      appBar: MSosAppBar(title: isEdition ? "Editar Alerta" : "Crear Alerta", icon: Icons.crisis_alert),
      drawer: const MSosDashboard(),
      drawerEnableOpenDragGesture: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: const MSosAlertButton(),
      bottomNavigationBar: const CustomBottomAppBar(isFromAlertScreen: true),
      body: Container(
          alignment: Alignment.topLeft,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              child: Padding(
                padding: EdgeInsets.fromLTRB(screenWidth * 0.08, 0, screenWidth * 0.08, 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MSosText(
                            isEdition ? state.alertNameCtrl.text : "Crear Alerta",
                            style: MSosText.subtitleStyle,
                            icon: Icons.add_circle_rounded,
                          ),
                          const SizedBox(height: 20),
                          Form(
                            key: _formKey,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              MSosFormField(
                                label: "Nombre de la Alerta",
                                controller: state.alertNameCtrl,
                              ),
                              const SizedBox(height: 10),
                              MSosFormField(
                                label: "Mensaje de auxilio",
                                isMultiLine: true,
                                controller: state.messageCtrl,
                              ),
                              const SizedBox(height: 10),
                              const MSosText("Tiempo de tolerancia"),
                              const SizedBox(height: 4),
                              CupertinoSlidingSegmentedControl<int>(
                                  thumbColor: MSosColors.blue,
                                  groupValue: state.toleranceTimeOption,
                                  children: {
                                    0: MSosText(
                                      '10s',
                                      style: MSosText.normalStyle,
                                      textColor: state.toleranceTimeOption != 0 ? null : MSosColors.white,
                                    ),
                                    1: MSosText('30s',
                                        style: MSosText.normalStyle,
                                        textColor: state.toleranceTimeOption != 1 ? null : MSosColors.white),
                                    2: MSosText('60s',
                                        style: MSosText.normalStyle,
                                        textColor: state.toleranceTimeOption != 2 ? null : MSosColors.white),
                                    3: MSosText('120s',
                                        style: MSosText.normalStyle,
                                        textColor: state.toleranceTimeOption != 3 ? null : MSosColors.white),
                                    4: MSosText('300s',
                                        style: MSosText.normalStyle,
                                        textColor: state.toleranceTimeOption != 4 ? null : MSosColors.white)
                                  },
                                  onValueChanged: (groupValue) {
                                    // In this case we don't need to update the bloc state until the save button is pressed
                                    setState(() {
                                      state.toleranceTimeOption = groupValue ?? 0;
                                      provider.changeToleranceTime();
                                    });
                                  }),
                              const SizedBox(height: 20),
                              const MSosText("Compartir ubicación al habilitar"),
                              const SizedBox(height: 2),
                              CupertinoSwitch(
                                  value: state.shareLocation,
                                  activeColor: MSosColors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      state.shareLocation = value;
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
                                                    state.triggers['button_trigger'] =
                                                        !state.triggers['button_trigger'];
                                                  });
                                                },
                                                style: IconButton.styleFrom(
                                                    backgroundColor: state.triggers['button_trigger']
                                                        ? MSosColors.blue
                                                        : MSosColors.grayLight),
                                                icon: const FaIcon(
                                                  FontAwesomeIcons.mobileButton,
                                                  color: MSosColors.white,
                                                )),
                                            const MSosText(
                                              "desde aplicación",
                                              size: 12,
                                              alignment: TextAlign.center,
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.30,
                                        child: Column(
                                          children: [
                                            IconButton.filled(
                                                onPressed: () {
                                                  setState(() {
                                                    state.triggers['smartwatch_trigger'] =
                                                        !state.triggers['smartwatch_trigger'];
                                                  });
                                                },
                                                style: IconButton.styleFrom(
                                                    backgroundColor: state.triggers['smartwatch_trigger']
                                                        ? MSosColors.blue
                                                        : MSosColors.grayLight),
                                                icon: const Icon(
                                                  Icons.watch_rounded,
                                                  color: MSosColors.white,
                                                )),
                                            const MSosText(
                                              'desde smartwatch',
                                              size: 12,
                                              alignment: TextAlign.center,
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
                                                    state.triggers['disconnection_trigger'] =
                                                        !state.triggers['disconnection_trigger'];
                                                  });
                                                },
                                                style: IconButton.styleFrom(
                                                    backgroundColor: state.triggers['disconnection_trigger']
                                                        ? MSosColors.blue
                                                        : MSosColors.grayLight),
                                                icon: const FaIcon(
                                                  FontAwesomeIcons.towerCell,
                                                  color: MSosColors.white,
                                                  size: 18,
                                                )),
                                            const MSosText(
                                              'desconexión con la red',
                                              size: 12,
                                              alignment: TextAlign.center,
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
                                                    state.triggers['smartwatch_disconnection_trigger'] =
                                                        !state.triggers['smartwatch_disconnection_trigger'];
                                                  });
                                                },
                                                style: IconButton.styleFrom(
                                                    backgroundColor: state.triggers['smartwatch_disconnection_trigger']
                                                        ? MSosColors.blue
                                                        : MSosColors.grayLight),
                                                icon: const Icon(
                                                  Icons.watch_off,
                                                  color: MSosColors.white,
                                                )),
                                            const MSosText(
                                              'desconexión smartwatch',
                                              size: 12,
                                              alignment: TextAlign.center,
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
                                                    state.triggers['voice_trigger'] = !state.triggers['voice_trigger'];
                                                  });
                                                },
                                                style: IconButton.styleFrom(
                                                    backgroundColor: state.triggers['voice_trigger']
                                                        ? MSosColors.blue
                                                        : MSosColors.grayLight),
                                                icon: const FaIcon(
                                                  FontAwesomeIcons.microphone,
                                                  color: MSosColors.white,
                                                )),
                                            const MSosText(
                                              'activación por voz',
                                              size: 12,
                                              alignment: TextAlign.center,
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
                                                    state.triggers['backtap_trigger'] =
                                                        !state.triggers['backtap_trigger'];
                                                  });
                                                },
                                                style: IconButton.styleFrom(
                                                    backgroundColor: state.triggers['backtap_trigger']
                                                        ? MSosColors.blue
                                                        : MSosColors.grayLight),
                                                icon: const FaIcon(
                                                  FontAwesomeIcons.solidHandPointUp,
                                                  size: 20,
                                                  color: MSosColors.white,
                                                )),
                                            const MSosText(
                                              'sensor backtap',
                                              size: 12,
                                              alignment: TextAlign.center,
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
                                callbackFunction: () async {
                                  provider.saveAlert().then((errorMessage) {
                                    if (errorMessage != null) {
                                      MSosFloatingMessage.showMessage(context,
                                          message: errorMessage, type: MSosMessageType.alert);
                                    } else {
                                      Navigator.pushNamed(context, '/alert_list');
                                    }
                                  });
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
