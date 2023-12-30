import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistas_amatista/providers/disconnection_menu_provider.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_appbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

class DisconnectionMenu extends StatelessWidget {
  const DisconnectionMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final provider = context.read<DisconnectionProvider>();
    final state = context.watch<DisconnectionProvider>();
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: const MSosAppBar(title: 'Desconexión a red', icon: Icons.wifi_off_rounded),
        drawerEnableOpenDragGesture: false,
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
                        "El servicio por desconexión se encarga de monitorear que tu teléfono se encuentre conectado a internet, actualizando tu ubicación de forma periódica mientras el servicio esté activado. En caso de una desconexión prolongada, este se encargará de enviar el mensaje de alerta correspondiente",
                        isMultiline: true,
                        style: MSosText.infoStyle,
                        icon: Icons.info,
                      ),
                      const SizedBox(height: 10),
                      const MSosText(
                        "Configuración",
                        style: MSosText.subtitleStyle,
                      ),
                      const SizedBox(height: 10),
                      const MSosText("¿Habilitar Servicio?"),
                      const SizedBox(height: 5),
                      CupertinoSwitch(
                        value: state.isGlobalyEnabled,
                        onChanged: (value) {
                          provider.toggleGlobalyEnabled(value);
                          Navigator.popAndPushNamed(context, '/home');
                        },
                        activeColor: MSosColors.blue,
                      ),
                      const SizedBox(height: 10),
                      const MSosText("Frecuencia de Actualización de Ubicación"),
                      const SizedBox(height: 5),
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
                    ],
                  ),
                ),
              ),
            )));
  }
}
