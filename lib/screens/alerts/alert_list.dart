import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistas_amatista/providers/alert_provider.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_appbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_bottombar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_button.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_dashboard.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_floating_alert_button.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_list_item_card.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

/* Vista de configuración para el disparador/activador de alerta provocado
por una desconexión a internet.*/

class AlertSettingsScreen extends StatelessWidget {
  const AlertSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Obtaining screen dimensions for easier to read code.
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height - 60;
    final state = context.watch<AlertProvider>();
    final provider = context.read<AlertProvider>();
    provider.getAlertsLists();

    return Scaffold(
        resizeToAvoidBottomInset: true, //Used to not resize when keyboard appears
        appBar: const MSosAppBar(title: 'Alertas', icon: Icons.crisis_alert),
        drawer: const MSosDashboard(),
        bottomNavigationBar: const CustomBottomAppBar(isFromAlertScreen: true),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: const MSosAlertButton(),
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
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const MSosText(
                              "Alertas Creadas",
                              style: MSosText.subtitleStyle,
                              icon: Icons.list,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // TODO: Crear la lista dinámica de las alertas configuradas por medio de Bloc
                            SizedBox(
                              height: screenHeight * 0.4,
                              child: ListView.separated(
                                itemCount: state.alerts.length,
                                separatorBuilder: (BuildContext context, int index) => const Divider(
                                  height: 8,
                                  color: MSosColors.white,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return MSosListItemCard(
                                    title: state.alerts[index].name,
                                    callback: () {
                                      // Load the state of the next Screen, and Push it with the initial values from selected alert
                                      provider.editionContext(state.alerts[index]);
                                      Navigator.pushNamed(context, '/alert_menu');
                                    },
                                    deleteCallback: () {
                                      final result = provider.deleteAlert(state.alerts[index]);
                                    },
                                  );
                                },
                              ),
                            ),
                            MSosButton(
                              text: "Crear",
                              callbackFunction: () {
                                provider.creationContext();
                                Navigator.pushNamed(context, '/alert_menu');
                              },
                              style: MSosButton.smallButton,
                              color: MSosColors.blue,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const MSosText(
                              "Puedes habilitar solo una alerta a la vez, al hacerlo todos los disparadores y propiedades de la alerta configurada como el mensaje y servicios utilizados comenzarán a operar de fondo con lo que las alertas se activarán para un grupo en específico que hayas seleccionado",
                              size: 12,
                              style: MSosText.infoStyle,
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
            )));
  }
}
