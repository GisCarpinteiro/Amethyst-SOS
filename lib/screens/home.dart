import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_appbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_bottombar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_button.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_dashboard.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key); // Corregir el uso de super

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: const MSosAppBar(
          title: "Home",
          icon: Icons.home,
        ),
        drawer: const MSosDashboard(),
        bottomNavigationBar: const CustomBottomAppBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: FloatingActionButton.large(
          backgroundColor: MSosColors.pink,
          shape: const CircleBorder(),
          onPressed: () {
            // TODO: Implementar las alertaaaas!!!
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // TODO: Hacer que ambos botones invoquen el menú flotante
                          MSosButton(text: "ALERTA", style: MSosButton.multiOptionButton),
                          MSosButton(text: "GRUPO", style: MSosButton.multiOptionButton),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        MSosButton(
                          text: "    INICIAR    ",
                          style: MSosButton.smallButton,
                          color: MSosColors.blue,
                          callbackFunction: () {
                            // TODO: Iniciar el servicio de alertas!!!!
                            FlutterLogs.logInfo("Home", "Start Service Button Callback", "Starting Alert Service...");
                          },
                        )
                      ])
                    ],
                  ),
                ),
              ),
            )));
    // TODO: Crear navBar 😞
  }
}
