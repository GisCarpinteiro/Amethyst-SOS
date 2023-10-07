import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_appbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_dashboard.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MSosAppBar(title: "Home ", icon: FontAwesomeIcons.house),
      drawer: MSosDashboard(),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
        MSosText(
          "Under Construction 👷‍♀️",
          size: 43,
          style: MSosText.normalStyle,
        ),
      ]),
    );
    // TODO: Crear navBar 😞
  }
}
