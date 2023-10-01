import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vistas_amatista/blocs/group_blocs/group_menu/group_menu_bloc.dart';
import 'package:vistas_amatista/blocs/routine_blocs/routine_list/routine_list_bloc.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_appbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_button.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_list_item_card.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_snackbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

/* Vista de configuración para el disparador/activador de alerta provocado
por una desconexión a internet.*/

class RoutineListScreen extends StatelessWidget {
  const RoutineListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We trigger the event to fetch the groups on the screen inicialization
    BlocProvider.of<RoutineListBloc>(context, listen: false).add(const GetRoutineListEvent());

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height - 60;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const MSosAppBar(title: 'Rutinas', icon: Icons.people_alt_rounded),
      body: BlocBuilder<RoutineListBloc, RoutineListState>(
        builder: (context, state) {
          return Container(
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
                        Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                                          callback: () => MSosSnackBar.showInfoMessage(context, message: "aún no hace nada esto jeje"));
                                    },
                                  ),
                                ),
                          MSosButton(
                            text: "Crear Rutina",
                            callbackFunction: () {
                              BlocProvider.of<GroupMenuBloc>(context, listen: false).add(InitialCreateGroupEvent(context: context));
                            },
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
                        ]),
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
