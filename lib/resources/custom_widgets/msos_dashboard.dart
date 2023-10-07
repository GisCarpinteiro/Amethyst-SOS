import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

class MSosDashboard extends StatelessWidget {
  const MSosDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: ListView(
          children: [
            const Row(
              children: [
                SizedBox(width: 20),
                FaIcon(FontAwesomeIcons.solidGem, color: MSosColors.amethyst),
                SizedBox(width: 10),
                MSosText(
                  "AMATISTA",
                  style: MSosText.wizardTitleStyle,
                  textColor: MSosColors.black,
                )
              ],
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text('Inicio'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Alertas'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Grupos'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Rutinas'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Activadores'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Mapa de Riesgos'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
    );
  }
}
