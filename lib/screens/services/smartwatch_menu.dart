import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistas_amatista/providers/smartwatch_provider.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_appbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_button.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_dashboard.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_snackbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

class SmartwatchMenu extends StatelessWidget {
  const SmartwatchMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final state = context.watch<SmartwatchProvider>();
    final provider = context.read<SmartwatchProvider>();

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: const MSosAppBar(title: 'Smartwatch', icon: Icons.watch),
        body: Container(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(screenWidth * 0.08, 0, screenWidth * 0.08, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MSosText(
                        "Estado",
                        style: MSosText.subtitleStyle,
                      ),
                      const SizedBox(height: 10),
                      const MSosText(
                        "El smartwatch no se ha sincronizado aún!",
                        alignment: TextAlign.justify,
                      ),
                      const SizedBox(height: 10),
                      MSosButton(
                        text: "Sincronizar",
                        style: MSosButton.smallButton,
                        color: MSosColors.blue,
                        onPressed: () {
                          provider.syncWatch().then((errorMessage) {
                            if (errorMessage == null) {
                              MSosFloatingMessage.showMessage(context,
                                  message: "Reloj emparejado!", type: MSosMessageType.info);
                              Navigator.pushNamed(context, '/home');
                            } else {
                              MSosFloatingMessage.showMessage(
                                context,
                                title: "No fué posible sincronizarse con el smartwatch.",
                                message: "Verifique que emparejado y que la app Amatista está abierta",
                                type: MSosMessageType.alert,
                              );
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      const MSosText(
                        "Configuración",
                        style: MSosText.subtitleStyle,
                      ),
                      const SizedBox(height: 10),
                      const MSosText(
                        "Tiempo de tolerancia por desconexión",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CupertinoSlidingSegmentedControl<int>(
                        thumbColor: MSosColors.blue,
                        groupValue: state.toleranceTimeOption,
                        children: {
                          0: MSosText(
                            '1 min',
                            style: MSosText.normalStyle,
                            textColor: state.toleranceTimeOption != 0 ? null : MSosColors.white,
                          ),
                          1: MSosText('2 min',
                              style: MSosText.normalStyle,
                              textColor: state.toleranceTimeOption != 1 ? null : MSosColors.white),
                          2: MSosText('5 min ',
                              style: MSosText.normalStyle,
                              textColor: state.toleranceTimeOption != 2 ? null : MSosColors.white),
                          3: MSosText('10 min',
                              style: MSosText.normalStyle,
                              textColor: state.toleranceTimeOption != 3 ? null : MSosColors.white)
                        },
                        onValueChanged: (groupValue) {
                          // In this case we don't need to update the bloc state until the save button is pressed
                          provider.changeToleranceOption(groupValue!);
                        },
                      ),
                      const SizedBox(height: 10),
                      const MSosText(
                        "Es el tiempo que la app esperará antes de tratar de activar la alerta de forma automática al detectar la desconexión del smartwatch, se recomienda establecerlo en 2 o 5 minutos",
                        style: MSosText.infoStyle,
                      ),
                      const SizedBox(height: 15),
                      const MSosText(
                        "¿Sincronizar de forma automática siempre que sea posible?",
                        isMultiline: true,
                      ),
                      const SizedBox(height: 10),
                      CupertinoSwitch(
                          value: state.automaticSincronization,
                          activeColor: MSosColors.blue,
                          onChanged: (value) => provider.changeAutomaticSincronization(value)),
                      const SizedBox(height: 10),
                      const MSosText(
                        "Si esta opción está habilitada, al iniciar la app en ambos dispositivos estos tratarán de sincronizarse de forma automática.",
                        style: MSosText.infoStyle,
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

  void setState(Null Function() param0) {}
}
