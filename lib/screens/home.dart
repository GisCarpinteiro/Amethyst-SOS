import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vistas_amatista/providers/alert_button_provider.dart';
import 'package:vistas_amatista/providers/home_provider.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_appbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_bottombar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_button.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_cardbutton.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_dashboard.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_alert_button.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_option_card.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_pop_up_menu.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_snackbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';
import 'package:vistas_amatista/services/smartwatch_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  // Corregir el uso de super
  @override
  Widget build(BuildContext context) {
    // * >>>>>> HOME PROVIDER INIT>>>>>>>>
    final double screenWidth = MediaQuery.of(context).size.width;
    //We initialize the view by fetching the saved values from the configs
    final HomeProvider provider = context.read<HomeProvider>();
    final AlertButtonProvider alertButtonProvider = context.read<AlertButtonProvider>();
    final HomeProvider state = context.watch<HomeProvider>();
    provider.getAlertAndGroupList();
    SmartwatchService.homeProvider = provider;
    SmartwatchService.bottomBarProvider = alertButtonProvider;
    SmartwatchService.startListening2Watch();
    late MSosPopUpMenu selectAlertPopUpMenu;
    late MSosPopUpMenu selectGroupPopUpMenu;

//* -------------------------- >>> POP_UP MENUS <<< -------------------------------------------
    selectAlertPopUpMenu = MSosPopUpMenu(context,
        title: "Alertas",
        formChildren: state.alerts.map((alert) {
          return MSosOptionCard(
            title: alert.name,
            isSelected: alert == state.selectedAlert,
            callback: () {
              provider.selectAlert(alert);
              selectAlertPopUpMenu.dismissPopUpMenu();
            },
          );
        }).toList());

    selectGroupPopUpMenu = MSosPopUpMenu(context,
        title: "Grupos",
        formChildren: state.groups.map((group) {
          return MSosOptionCard(
            title: group.name,
            isSelected: group == state.selectedGroup,
            callback: () {
              provider.selectGroup(group);
              selectGroupPopUpMenu.dismissPopUpMenu();
            },
          );
        }).toList());
    // * >>>>>> NAVBAR PROVIDER INIT >>>>>>>>

    return Scaffold(
        appBar: const MSosAppBar(
          title: "Home",
          icon: FontAwesomeIcons.house,
        ),
        drawer: const MSosDashboard(),
        bottomNavigationBar: const CustomBottomAppBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: const MSosAlertButton(),
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
                      const SizedBox(height: 20),
//* ----------------------------- >>> TRIGGERS PANEL <<< ----------------------------------
                      const MSosText(
                        "Activadores",
                        style: MSosText.subtitleStyle,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MSosMiniButton(
                                text: "desconexión",
                                callback: () {},
                                isActive: true,
                              ),
                              MSosMiniButton(
                                text: "backtap",
                                callback: () {},
                                isActive: false,
                                isDisabled: true,
                              ),
                              MSosMiniButton(
                                text: "smartwatch",
                                callback: () {},
                                isActive: false,
                                isDisabled: true,
                              ),
                            ],
                          ),
                          const Row(),
                        ],
                      ),
                      const SizedBox(height: 20),
//* ----------------------------- >>> SERVICES PANEL <<< ----------------------------------
                      const MSosText(
                        "Servicios",
                        style: MSosText.subtitleStyle,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          MSosCardButton(
                            title: "Mapa de Riesgos",
                            icon: FontAwesomeIcons.earthAmericas,
                            isDisabled: true,
                            onPressed: () {},
                          ),
                          const SizedBox(width: 10),
                          MSosCardButton(
                            title: "Smart Watch",
                            icon: Icons.watch,
                            onPressed: () {
                              Navigator.pushNamed(context, '/smartwatch_menu');
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
//* ----------------------------- >>> START SERVICE PANEL <<< -----------------------
                      const MSosText(
                        "INICIAR",
                        style: MSosText.subtitleStyle,
                      ),
                      // * >>>> Alert and Group Picker Section <<<<
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MSosButton(
                            text: state.selectedAlert == null ? "" : state.selectedAlert!.name,
                            style: MSosButton.multiOptionButton,
                            onPressed: () => {
                              if (!state.isServiceEnabled) {selectAlertPopUpMenu.showPopUpMenu(context)}
                            },
                          ),
                          MSosButton(
                            text: state.selectedGroup == null ? "" : state.selectedGroup!.name,
                            style: MSosButton.multiOptionButton,
                            onPressed: () => {
                              if (!state.isServiceEnabled) {selectGroupPopUpMenu.showPopUpMenu(context)}
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        MSosButton(
                            text: state.isServiceEnabled ? "     Detener     " : "     Iniciar     ",
                            style: MSosButton.smallButton,
                            color: state.isServiceEnabled ? MSosColors.pink : MSosColors.blue,
                            onPressed: () {
                              if (state.isServiceEnabled) {
                                provider.stopAlertService(context).then((errorMessage) {
                                  if (errorMessage != null) {
                                    MSosFloatingMessage.showMessage(context,
                                        message: errorMessage, type: MSosMessageType.alert);
                                  } else {
                                    MSosFloatingMessage.showMessage(context,
                                        message: "Se ha detenido el servicio correctamente",
                                        type: MSosMessageType.info);
                                  }
                                });
                              } else {
                                provider.startAlertService(context).then((errorMessage) {
                                  if (errorMessage != null) {
                                    MSosFloatingMessage.showMessage(context,
                                        message: errorMessage, type: MSosMessageType.alert);
                                  } else {
                                    MSosFloatingMessage.showMessage(context,
                                        message: "Se ha iniciado el servicio correctamente",
                                        type: MSosMessageType.info);
                                  }
                                });
                              }
                            }),
                      ])
                    ],
                  ),
                ),
              ),
            )));
  }
}

// * ------------------ >>> CUSTOM WIDGETS (ONLY USED IN HOME) <<< -----------------------------
class MSosMiniButton extends StatelessWidget {
  final bool isDisabled;
  final String text;
  final Color backgroundInactiveColor;
  final Color borderColor;
  final Color textColor;
  final double height;
  final double textSize;
  final VoidCallback? callback;
  final bool isActive;
  final Color textInactiveColor;
  final Color backgroundActiveColor;

  const MSosMiniButton({
    super.key,
    this.text = "Lorem Ipsum",
    this.isDisabled = false,
    this.textInactiveColor = MSosColors.white,
    this.backgroundInactiveColor = MSosColors.white,
    this.backgroundActiveColor = MSosColors.blue,
    this.borderColor = MSosColors.blueDark,
    this.textColor = MSosColors.white,
    this.height = 24,
    this.textSize = 12,
    this.callback,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      color: isDisabled
          ? MSosColors.white
          : isActive
              ? backgroundActiveColor
              : backgroundInactiveColor,
      height: 24,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: isDisabled ? MSosColors.grayLight : MSosColors.blueDark, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      elevation: 0,
      child: MSosText(
        text,
        textColor: isDisabled
            ? MSosColors.grayLight
            : isActive
                ? textColor
                : textInactiveColor,
        size: 12,
      ),
    );
  }
}
