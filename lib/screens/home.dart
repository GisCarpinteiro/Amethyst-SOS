import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:vistas_amatista/models/alert.dart';
import 'package:vistas_amatista/providers/bottombar_provider.dart';
import 'package:vistas_amatista/providers/home_provider.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_appbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_bottombar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_button.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_dashboard.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_list_item_card.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_option_card.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_pop_up_menu.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_snackbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  // Corregir el uso de super
  @override
  Widget build(BuildContext context) {
    // * >>>>>> HOME PROVIDER INIT>>>>>>>>
    final double screenWidth = MediaQuery.of(context).size.width;
    //We initialize the view by fetching the saved values from the configs
    final HomeProvider provider = context.read<HomeProvider>();
    final HomeProvider state = context.watch<HomeProvider>();
    provider.getAlertAndGroupList();
    late MSosPopUpMenu selectAlertPopUpMenu;
    late MSosPopUpMenu selectGroupPopUpMenu;

    selectAlertPopUpMenu = MSosPopUpMenu(context,
        title: "Alertas",
        formChildren: state.alerts.map((alert) {
          int alertIndex = state.alerts.indexOf(alert);
          return MSosOptionCard(
            title: alert.name,
            isSelected: alertIndex == state.selectedAlert,
            callback: () {
              provider.selectAlert(alertIndex);
              selectAlertPopUpMenu.dismissPopUpMenu();
            },
          );
        }).toList());

    selectGroupPopUpMenu = MSosPopUpMenu(context,
        title: "Grupos",
        formChildren: state.groups.map((group) {
          int groupIndex = state.groups.indexOf(group);
          return MSosOptionCard(
            title: group.name,
            isSelected: groupIndex == state.selectedGroup,
            callback: () {
              provider.selectGroup(groupIndex);
              selectGroupPopUpMenu.dismissPopUpMenu();
            },
          );
        }).toList());
    // * >>>>>> NAVBAR PROVIDER INIT >>>>>>>>
    final ButtomBarProvider barProvider = context.read<ButtomBarProvider>();
    final ButtomBarProvider barStatus = context.watch<ButtomBarProvider>();

    return Scaffold(
        appBar: const MSosAppBar(
          title: "Home",
          icon: Icons.home,
        ),
        drawer: const MSosDashboard(),
        bottomNavigationBar: const CustomBottomAppBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: FloatingActionButton.large(
          backgroundColor: barStatus.alertButtonEnabled ? MSosColors.pink : MSosColors.grayMedium,
          shape: const CircleBorder(),
          onPressed: () {
            if (!state.isServiceEnabled) return;
            // TODO: Implementar las alertaaaas!!!
            MSosFloatingMessage.showMessage(context, message: "¡Se ha activado la alerta!", type: MessageType.alert);
          },
          child: Image.asset(
            'lib/resources/assets/images/alert_icon.png', // Ruta de la imagen dentro de la carpeta "assets"
            width: 70, // Ancho de la imagen
            height: 70,
          ),
        ),
        body: Container(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(screenWidth * 0.08, 0, screenWidth * 0.08, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const MSosText(
                        "Mapa de Riesgos",
                        style: MSosText.subtitleStyle,
                      ),
                      const Placeholder(
                        fallbackHeight: 180,
                        color: MSosColors.grayMedium,
                      ),
                      const SizedBox(height: 20),
                      const MSosText(
                        "Indicadores",
                        style: MSosText.subtitleStyle,
                      ),
                      const Placeholder(
                        fallbackHeight: 140,
                        color: MSosColors.grayMedium,
                      ),
                      const SizedBox(height: 20),
                      const MSosText(
                        "Servicio",
                        style: MSosText.subtitleStyle,
                      ),
                      // * >>>> Alert and Group Picker Section <<<<
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // TODO: Hacer que ambos botones invoquen el menú flotante
                          MSosButton(
                            text: state.alerts.isEmpty ? "" : state.alerts[state.selectedAlert].name,
                            style: MSosButton.multiOptionButton,
                            callbackFunction: () => selectAlertPopUpMenu.showPopUpMenu(context),
                          ),
                          MSosButton(
                            text: state.groups.isEmpty ? "" : state.groups[state.selectedGroup].name,
                            style: MSosButton.multiOptionButton,
                            callbackFunction: () => selectGroupPopUpMenu.showPopUpMenu(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        MSosButton(
                            text: state.isServiceEnabled ? "     Detener     " : "     Iniciar     ",
                            style: MSosButton.smallButton,
                            color: state.isServiceEnabled ? MSosColors.pink : MSosColors.blue,
                            callbackFunction: () {
                              FlutterLogs.logInfo("ButtomBar", "Start Service Button Callback", "Starting Alert Service...");
                              // TODO: Iniciar el servicio de alertas!!!!
                              provider.toggleServiceEnabled();
                              if (state.isServiceEnabled) {
                                MSosFloatingMessage.showMessage(
                                  context,
                                  title: "Servicio Activado",
                                  message: 'Alerta "${state.alerts[state.selectedAlert]}" habilitada',
                                  type: MessageType.info,
                                );
                                barProvider.enableAlertButton();
                              } else {
                                barProvider.disableAlertButton();
                                MSosFloatingMessage.showMessage(
                                  context,
                                  title: "Servicio Desactivado",
                                  message: 'Alerta "${state.alerts[state.selectedAlert]}" deshabilitada',
                                );
                              }
                            }),
                      ])
                    ],
                  ),
                ),
              ),
            )));
    // TODO: Crear navBar 😞
  }
}
