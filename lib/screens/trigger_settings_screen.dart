import 'package:flutter/material.dart';
import 'package:vistas_amatista/custom_widgets/custom_app_bar.dart';
import '../custom_widgets/text_custom.dart';


/* Esta vista es temporal, usada para probar las funcionalidades del proyecto por separado de 
forma independiente. Está hecha con el propósito de testear funcionalidades más fácilmente sin 
necesidad de tener que configurar un perfil desde 0 o depender de otras funciones/vistas para 
poder acceder a ellas.*/

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
      appBar: CustomAppBar(title: 'Activadores', icon: Icons.sensors_rounded),
      body: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.fromLTRB(screenWidth * 0.12, 50, screenWidth * 0.12, 50),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
              ],
            ),
          ),
        )
      ),
    );
  }
}







