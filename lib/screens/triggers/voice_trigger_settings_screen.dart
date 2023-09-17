import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistas_amatista/blocs/trigger_blocs/trigger_config_bloc.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_appbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_button.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_formfield.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

/* Vista de configuración para el disparador/activador de alerta provocado
por una desconexión a internet.*/

class VoiceTriggerSettingsScreen extends StatefulWidget {
  const VoiceTriggerSettingsScreen({super.key});

  @override
  State<VoiceTriggerSettingsScreen> createState() => _VoiceTriggerSettingsScreenState();
}

class _VoiceTriggerSettingsScreenState extends State<VoiceTriggerSettingsScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //Obtaining screen dimensions for easier to read code.
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true, //Used to not resize when keyboard appears
      appBar: const MSosAppBar(title: 'Activación por voz', icon: Icons.record_voice_over_rounded),
      body: BlocBuilder<TriggerConfigBloc, TriggerConfigState>(
        builder: (context, state) {
          return Container(
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(screenWidth * 0.08, 0, screenWidth * 0.08, 80),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MSosText(
                            "Funcionamiento",
                            style: MSosText.subtitleStyle,
                            icon: Icons.info,
                          ),
                          const MSosText(
                            "Puedes establecer palabras claves que te permitirán activar por voz las alertas que usen este activador. Es importante considerar que activador puede consumir mucha batería por lo que se recomienda usarse solo en alertas que permanecerán activadas un par de horas",
                            size: 12,
                            style: MSosText.infoStyle,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const MSosText(
                            "Configuración de Activador",
                            style: MSosText.subtitleStyle,
                          ),
                          const MSosText(
                            '¿Disponible globalmente en las alertas?',
                            style: MSosText.normalStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              state.isEnabled
                                  ? const MSosText(
                                      'Activado para todas las alertas',
                                      style: MSosText.normalStyle,
                                      size: 12,
                                      textColor: MSosColors.grayMedium,
                                    )
                                  : const MSosText(
                                      'Desactivado para todas las alertas',
                                      style: MSosText.normalStyle,
                                      size: 12,
                                      textColor: MSosColors.grayMedium,
                                    ),
                              CupertinoSwitch(
                                  value: state.isEnabled,
                                  activeColor: MSosColors.blue,
                                  onChanged: (value) {
                                    BlocProvider.of<TriggerConfigBloc>(context, listen: false)
                                        .add(UpdateVoiceCommandTriggerConfig(value, state.voiceCommand, state.toleranceTime));
                                  }),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const MSosText(
                            'Tiempo de tolerancia para cancelar la alarma al detectar palabras clave:',
                            style: MSosText.normalStyle,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CupertinoSlidingSegmentedControl<int>(
                              thumbColor: MSosColors.blue,
                              groupValue: state.toleranceTime,
                              children: {
                                0: MSosText(
                                  '10s',
                                  style: MSosText.normalStyle,
                                  textColor: state.toleranceTime != 0 ? null : MSosColors.white,
                                ),
                                1: MSosText('30s',
                                    style: MSosText.normalStyle, textColor: state.toleranceTime != 1 ? null : MSosColors.white),
                                2: MSosText('60s',
                                    style: MSosText.normalStyle, textColor: state.toleranceTime != 2 ? null : MSosColors.white),
                                3: MSosText('120s',
                                    style: MSosText.normalStyle, textColor: state.toleranceTime != 3 ? null : MSosColors.white)
                              },
                              onValueChanged: (groupValue) {
                                BlocProvider.of<TriggerConfigBloc>(context, listen: false)
                                    .add(UpdateVoiceCommandTriggerConfig(state.isEnabled, state.voiceCommand, groupValue!));
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          const MSosText("Palabras Clave", style: MSosText.subtitleStyle),
                          const MSosText(
                              "Se recomiendan combinaciones de 2 palabras para evitar falsas activaciones y facilitar la detección"),
                          const SizedBox(
                            height: 10,
                          ),
                          Form(
                            key: _formKey,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                MSosFormField(
                                  hintText: '"amatista morada"',
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                MSosButton(
                                  text: 'Cambiar',
                                  style: MSosButton.smallButton,
                                  //TODO: function to update the safe word,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const MSosText("probar activador", style: MSosText.subtitleStyle),
                          const MSosText(
                              'Presione el botón "probar", la aplicación comenzará a escuchar lo que le digas durante un breve periodo de tiempo y pintará el siguiente texto de azul de haber detectado la palabra clave establecida'),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  MSosText("Palabra detectada!", style: MSosText.infoStyle),
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  // TODO: Implementación de voice2text
                                },
                                style: TextButton.styleFrom(backgroundColor: MSosColors.blue, foregroundColor: Colors.white),
                                child: const MSosText(
                                  'Test',
                                  style: MSosText.buttonStyle,
                                  size: 14,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
