import 'package:flutter/material.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_appbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_bottombar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key); // Corregir el uso de super

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MSosAppBar(
        title: "Home",
        icon: Icons.home,
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: MSosColors.pink,
        child: Image.asset(
          'lib/resources/assets/images/alert_icon.png', // Ruta de la imagen dentro de la carpeta "assets"
          width: 70, // Ancho de la imagen
          height: 70,
        ),
        onPressed: () {
          print('hola');
        },
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MSosText(
            "Under Construction 👷‍♀️",
            size: 43,
            style: MSosText.normalStyle,
          ),
        ],
      ),
    );
    // TODO: Crear navBar 😞
  }
}
