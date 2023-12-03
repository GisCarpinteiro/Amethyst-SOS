import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vistas_amatista/controller/firestore_controller.dart';
import 'package:vistas_amatista/controller/shared_preferences_manager.dart';
import 'package:vistas_amatista/providers/login_provider.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_button.dart';
import 'package:vistas_amatista/services/alert_services/alert_manager.dart';
import 'package:watch_connectivity/watch_connectivity.dart';
import '../resources/custom_widgets/msos_text.dart';

/* Esta vista es temporal, usada para probar las funcionalidades del proyecto por separado de 
forma independiente. Está hecha con el propósito de testear funcionalidades más fácilmente sin 
necesidad de tener que configurar un perfil desde 0 o depender de otras funciones/vistas para 
poder acceder a ellas.*/

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  @override
  Widget build(BuildContext context) {
    const userid = "thisIsACustomId";
    //Obtaining screen dimensions for easier to read code.
    final double screenWidth = MediaQuery.of(context).size.width;
    //final double screenHeight = MediaQuery.of(context).size.height;
    final provider = context.read<LoginProvider>();

    return Scaffold(
      resizeToAvoidBottomInset: true, //Used to not resize when keyboard appears
      body: Container(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.fromLTRB(screenWidth * 0.12, 50, screenWidth * 0.12, 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const MSosText(
                    "Test/Demo Screen!",
                    style: MSosText.sectionTitleStyle,
                    icon: Icons.construction_outlined,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const MSosButton(
                    text: "Wizard",
                    route: '/startup',
                    style: MSosButton.subMenuLargeBtn,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MSosButton(
                      text: "Home",
                      style: MSosButton.subMenuLargeBtn,
                      onPressed: () {
                        final sharedPrefsInstance = SharedPrefsManager.sharedInstance;
                        if (sharedPrefsInstance != null) {
                          final userId = sharedPrefsInstance.getString('id');
                          if (userId == null) {
                            provider.logWithEmail();
                          } else {
                            FlutterLogs.logInfo("Demo", "HomeButton", "User already logged with id = $userId");
                          }
                        }
                        Navigator.pushNamed(context, '/home');
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  MSosButton(
                    text: "POST",
                    style: MSosButton.subMenuLargeBtn,
                    onPressed: () {
                      AlertService.postBackend(userid);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MSosButton(
                    text: "DEL",
                    style: MSosButton.subMenuLargeBtn,
                    onPressed: () {
                      AlertService.delBackend(userid);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MSosButton(
                    text: "PUT",
                    style: MSosButton.subMenuLargeBtn,
                    onPressed: () {
                      AlertService.putBackend(userid);
                    },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
