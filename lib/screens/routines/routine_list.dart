import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistas_amatista/providers/routine_provider.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_appbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_bottombar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_button.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_dashboard.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_floating_alert_button.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_list_item_card.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

/* Vista de configuración para el disparador/activador de alerta provocado
por una desconexión a internet.*/

class RoutineListScreen extends StatelessWidget {
  const RoutineListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We trigger the event to fetch the groups on the screen inicialization

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height - 60;

    final RoutineProvider state = context.read<RoutineProvider>();
    final RoutineProvider provider = context.watch<RoutineProvider>();

    provider.getRoutineList();
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: const MSosAppBar(title: 'Rutinas', icon: Icons.people_alt_rounded),
        drawer: const MSosDashboard(),
        bottomNavigationBar: const CustomBottomAppBar(isFromAlertScreen: true),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: const MSosAlertButton(),
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
                            const MSosText(
                              "Rutinas Configuradas",
                              style: MSosText.subtitleStyle,
                              icon: Icons.list,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            state.routines.isEmpty
                                ? const MSosText(
                                    "Aún no ha creado ningúna rutina",
                                    textColor: MSosColors.pink,
                                  )
                                : SizedBox(
                                    height: state.routines.length * 70,
                                    child: ListView.separated(
                                      itemCount: state.routines.length,
                                      separatorBuilder: (BuildContext context, int index) => const Divider(
                                        height: 8,
                                        color: MSosColors.white,
                                      ),
                                      itemBuilder: (BuildContext context, int index) {
                                        return MSosListItemCard(
                                          title: state.routines[index].name,
                                          callback: () => context
                                              .read<RoutineProvider>()
                                              .editRoutineContext(context, state.routines[index]),
                                          deleteCallback: () => {provider.deleteRoutine(state.routines[index])},
                                        );
                                      },
                                    ),
                                  ),
                            MSosButton(
                              text: "Crear Rutina",
                              callbackFunction: () => context.read<RoutineProvider>().createRoutineContext(context),
                              style: MSosButton.smallButton,
                              color: MSosColors.blue,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const MSosText(
                              "Las rutinas te permiten habilitar una alerta con un grupo en específico de forma programada en días y horas a las que sueles salir a la calle frecuentemente",
                              size: 12,
                              style: MSosText.infoStyle,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const MSosText(
                              "Las configuraciones como el tiempo de tolerancia o el tiempo de desactivación programada del servicio dependerán de lo que se haya configurado en la alerta seleccionada",
                              size: 12,
                              style: MSosText.infoStyle,
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
            )));
  }
}
