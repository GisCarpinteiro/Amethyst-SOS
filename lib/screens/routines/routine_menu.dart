import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vistas_amatista/providers/rotine_provider.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_appbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_dashboard.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

class RoutineMenuScreen extends StatelessWidget {
  const RoutineMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height - 60;

    final RoutineProvider state = context.read<RoutineProvider>();
    final RoutineProvider provider = context.watch<RoutineProvider>();

    provider.getRoutineList();
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: const MSosAppBar(title: 'Rutinas', icon: Icons.people_alt_rounded),
        drawer: const MSosDashboard(),
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
                            MSosText(
                              state.isEditionContext ? state.targetRoutine.name : "Crear Rutina",
                              style: MSosText.subtitleStyle,
                              icon: Icons.list,
                            ),
                            const SizedBox(height: 20),
                          ]),
                    ],
                  ),
                ),
              ),
            )));
  }
}
