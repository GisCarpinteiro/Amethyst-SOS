import 'package:flutter/material.dart';
import 'package:vistas_amatista/custom_widgets/btn_custom.dart';
import 'package:vistas_amatista/custom_widgets/custom_app_bar.dart';


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
      appBar: const CustomAppBar(title: 'Activadores', icon: Icons.sensors_rounded),
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
                BtnCustomWidget(text: "Botón de pánico", icon: Icons.radio_button_checked ,route: './not_found', style: BtnCustomWidget.subMenuLargeBtn),
                SizedBox(height: 10),
                BtnCustomWidget(text: "desconexión a internet", icon: Icons.signal_wifi_connected_no_internet_4 ,route: '/trigger_settings/internet_disconnection', style: BtnCustomWidget.subMenuLargeBtn),
                SizedBox(height: 10),
                BtnCustomWidget(text: "Botón en smartwatch", icon: Icons.watch ,route: './not_found', style: BtnCustomWidget.subMenuLargeBtn),
                SizedBox(height: 10),
                BtnCustomWidget(text: "Desconexión a smartwatch", icon: Icons.watch_off ,route: './not_found', style: BtnCustomWidget.subMenuLargeBtn),
                SizedBox(height: 10),
                BtnCustomWidget(text: "Sensor Backtap", icon: Icons.touch_app_rounded ,route: './not_found', style: BtnCustomWidget.subMenuLargeBtn),
                SizedBox(height: 10),
                BtnCustomWidget(text: "Por voz (palabra clave)", icon: Icons.record_voice_over_rounded ,route: './not_found', style: BtnCustomWidget.subMenuLargeBtn),
              ],
            ),
          ),
        )
      ),
    );
  }
}







