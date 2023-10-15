import 'package:flutter/material.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_button.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_appbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_dashboard.dart';

/* Vista del menú de configuración de disparadores/activadores*/

class TriggerSettingsScreen extends StatefulWidget {
  const TriggerSettingsScreen({super.key});

  @override
  State<TriggerSettingsScreen> createState() => _TriggerSettingsScreenState();
}

class _TriggerSettingsScreenState extends State<TriggerSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    //Obtaining screen dimensions for easier to read code.
    final double screenWidth = MediaQuery.of(context).size.width;
    //final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true, //Used to not resize when keyboard appears
      appBar: const MSosAppBar(title: 'Activadores', icon: Icons.sensors_rounded),
      drawer: const MSosDashboard(),
      body: Container(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.fromLTRB(screenWidth * 0.08, 0, screenWidth * 0.08, 50),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MSosButton(
                      text: "Botón de pánico",
                      icon: Icons.radio_button_checked,
                      route: '/not_found',
                      style: MSosButton.subMenuLargeBtn),
                  SizedBox(height: 20),
                  MSosButton(
                      text: "desconexión a internet",
                      icon: Icons.signal_wifi_connected_no_internet_4,
                      route: '/trigger_settings/internet_disconnection',
                      style: MSosButton.subMenuLargeBtn),
                  SizedBox(height: 20),
                  MSosButton(
                      text: "Botón en smartwatch",
                      icon: Icons.watch,
                      route: '/not_found',
                      style: MSosButton.subMenuLargeBtn),
                  SizedBox(height: 20),
                  MSosButton(
                      text: "Desconexión a smartwatch",
                      icon: Icons.watch_off,
                      route: '',
                      style: MSosButton.subMenuLargeBtn),
                  SizedBox(height: 20),
                  MSosButton(
                      text: "Sensor Backtap",
                      icon: Icons.touch_app_rounded,
                      route: '/not_found',
                      style: MSosButton.subMenuLargeBtn),
                  SizedBox(height: 20),
                  MSosButton(
                      text: "Por voz (palabra clave)",
                      icon: Icons.record_voice_over_rounded,
                      route: '/trigger_settings/voice_recognition',
                      style: MSosButton.subMenuLargeBtn),
                ],
              ),
            ),
          )),
    );
  }
}
