import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';
import 'package:vistas_amatista/screens/alerts/alert_list.dart';
import 'package:vistas_amatista/screens/groups/group_list.dart';
import 'package:vistas_amatista/screens/home.dart';
import 'package:vistas_amatista/screens/routines/routine_list.dart';
import 'package:vistas_amatista/screens/triggers/trigger_settings.dart';

class MSosDashboard extends StatelessWidget {
  const MSosDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 60, 10, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Row(
                  children: [
                    SizedBox(width: 10),
                    FaIcon(
                      FontAwesomeIcons.solidGem,
                      color: MSosColors.amethyst,
                      size: 35,
                    ),
                    SizedBox(width: 10),
                    MSosText(
                      "AMATISTA",
                      style: MSosText.wizardTitleStyle,
                      textColor: MSosColors.black,
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                const Row(
                  children: [
                    SizedBox(width: 20),
                    MSosText(
                      "DASHBOARD",
                      textColor: MSosColors.grayLight,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Inicio'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.alarm),
                  title: const Text('Alertas'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AlertSettingsScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.group),
                  title: const Text('Grupos'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const GroupListScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.route_outlined),
                  title: const Text('Rutinas'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RoutineListScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.gamepad),
                  title: const Text('Activadores'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TriggerSettingsScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.map),
                  title: const Text('Mapa de Riesgos'),
                  onTap: () {
                    // TODO: Agregar ruta
                  },
                ),
              ],
            ),
            Column(
              children: [
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: MSosColors.blue,
                  leading: const Icon(Icons.settings),
                  iconColor: MSosColors.white,
                  title: const Text('Configuración'),
                  textColor: MSosColors.white,
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                const Divider(),
                ListTile(
                  leading: const Image(
                    image: AssetImage('lib/resources/assets/images/user_icon.png'),
                  ),
                  title: Container(
                    alignment: Alignment.centerRight, // Alinea el contenido a la derecha
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Alinear el icono a la derecha
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ivanna Ramirez'),
                            MSosText(
                              "ivanna@gmail.com",
                              size: 13,
                              textColor: MSosColors.grayMedium,
                            ),
                            //Text('ivanna@gmail.com'),
                          ],
                        ),
                        Icon(Icons.settings), // Cambia 'some_icon' por el icono que desees
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
