import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vistas_amatista/custom_widgets/msos_button.dart';
import 'package:vistas_amatista/custom_widgets/msos_appbar.dart';
import 'package:vistas_amatista/custom_widgets/msos_text.dart';


/* Vista de configuración para el disparador/activador de alerta provocado
por una desconexión a internet.*/

class DiscconectTriggerSettingsScreen extends StatefulWidget {
  const DiscconectTriggerSettingsScreen({super.key});

  @override
  State<DiscconectTriggerSettingsScreen> createState() => _DiscconectTriggerSettingsScreenState();
}

class _DiscconectTriggerSettingsScreenState extends State<DiscconectTriggerSettingsScreen> {
  bool isTriggerEnabled = true;
  int? toleranceTimeValue = 0;

  @override
  Widget build(BuildContext context) {
    

    //Obtaining screen dimensions for easier to read code.
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height - 60;

    return Scaffold(
      resizeToAvoidBottomInset: true, //Used to not resize when keyboard appears
      appBar: const MSosAppBar(title: 'desconexión a red', icon: Icons.signal_wifi_connected_no_internet_4),
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
                      const MSosText("Funcionamiento", style: MSosText.subtitleStyle, icon: Icons.info,),
                      const MSosText(
                        "El activador por desconexión registrará la ubicación de tu dispositivo móvil de forma periódica a través de internet. Cuando una solicitud sea rechazada debido a una desconexión se esperará cierto tiempo para volver a intentar obtener la ubicación, si el segundo intento falla la alerta se activará desde un servidor que enviará los mensajes de alerta a los contactos de emergencia registrados",
                        size: 12,
                        style: MSosText.infoStyle,
                      ),
                      const SizedBox(height: 20,),
                      const MSosText("Configuración de Activador", style: MSosText.subtitleStyle,),
                      const MSosText('¿Disponible en las alertas?', style: MSosText.normalStyle,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          isTriggerEnabled?
                            const MSosText('Activado para todas las alertas', style: MSosText.normalStyle, size: 12, textColor: Color(0xFF777777),)
                            : const MSosText('Desactivado para todas las alertas', style: MSosText.normalStyle, size: 12, textColor: Color(0xFF777777),),
                          CupertinoSwitch(
                            value: isTriggerEnabled,
                            activeColor: const Color(0xFF7CC5E4),
                            onChanged: (value) {
                              setState(() {
                                isTriggerEnabled = value;
                                // TODO: Query para actualizar el JSON de configuración general y el de las alertas
                              });
                            }
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      const MSosText('Minutos de tolerancia ante desconexión:', style: MSosText.normalStyle,),
                      const SizedBox(height: 10,),
                      CupertinoSlidingSegmentedControl<int>(
                        thumbColor: const Color(0xFF7CC5E4),
                        groupValue: toleranceTimeValue,
                        children: {
                          0: MSosText('uno', style: MSosText.normalStyle, textColor: toleranceTimeValue!=0? null:const Color(0xFFFFFFFF) ,),
                          1: MSosText('dos', style: MSosText.normalStyle, textColor: toleranceTimeValue!=1? null:const Color(0xFFFFFFFF)),
                          2: MSosText('cinco', style: MSosText.normalStyle, textColor: toleranceTimeValue!=2? null:const Color(0xFFFFFFFF)),
                          3: MSosText('diez', style: MSosText.normalStyle, textColor: toleranceTimeValue!=3? null:const Color(0xFFFFFFFF))
                        }, onValueChanged: (groupValue){
                          setState(() {
                            toleranceTimeValue = groupValue;                     
                          });
                        }
                      ),
                      const MSosButton(text: "Prueba de Activador", route: '/trigger_test', style: MSosButton.subMenuLargeBtn)
                    ],
                  ),
                  const MSosButton(text: 'Guardar', route: '/not_found', style: MSosButton.continueLargeBtn)
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}
