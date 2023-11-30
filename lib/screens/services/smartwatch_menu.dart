import 'package:flutter/material.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_appbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_dashboard.dart';

class SmartwatchMenu extends StatelessWidget {
  const SmartwatchMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: MSosAppBar(title: 'Rutinas', icon: Icons.people_alt_rounded),
      drawer: MSosDashboard(),
      drawerEnableOpenDragGesture: false,
      body: Placeholder(),
    );
  }
}
