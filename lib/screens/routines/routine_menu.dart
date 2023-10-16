import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vistas_amatista/providers/rotine_provider.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/custom_buttons/msos_multi_option_button.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_appbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_dashboard.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_formfield.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_option_card.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_pop_up_menu.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_text.dart';

class RoutineMenuScreen extends StatefulWidget {
  const RoutineMenuScreen({super.key});

  @override
  State<RoutineMenuScreen> createState() => _RoutineMenuScreenState();
}

class _RoutineMenuScreenState extends State<RoutineMenuScreen> {
  final routineNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height - 60;

    final RoutineProvider state = context.read<RoutineProvider>();
    final RoutineProvider provider = context.watch<RoutineProvider>();

    late MSosPopUpMenu selectAlertPopUpMenu;
    late MSosPopUpMenu selectGroupPopUpMenu;
    late MSosPopUpMenu selectTimePopUpMenu;

    selectAlertPopUpMenu = MSosPopUpMenu(context,
        title: "Alertas",
        formChildren: state.alerts.map((alert) {
          return MSosOptionCard(
            title: alert.name,
            isSelected: state.selectedAlert != null ? (alert.id == state.selectedAlert!.id) : false,
            callback: () {
              provider.selectAlert(alert);
              selectAlertPopUpMenu.dismissPopUpMenu();
            },
          );
        }).toList());

    state.isEditionContext ? routineNameController.text = state.targetRoutine.name : "";

    selectGroupPopUpMenu = MSosPopUpMenu(context,
        title: "Grupos",
        formChildren: state.groups.map((group) {
          return MSosOptionCard(
            title: group.name,
            isSelected: state.selectedGroup != null ? (group.id == state.selectedAlert!.id) : false,
            callback: () {
              provider.selectGroup(group);
              selectGroupPopUpMenu.dismissPopUpMenu();
            },
          );
        }).toList());
    selectTimePopUpMenu = MSosPopUpMenu(context, title: "Hora de Activación", formChildren: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoTimerPicker(mode: CupertinoTimerPickerMode.hm, onTimerDurationChanged: (Duration) {}),
        ],
      )
    ]);

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
                            const MSosText("Nombre de la Rutina"),
                            MSosFormField(controller: routineNameController),
                            const SizedBox(height: 10),
                            const MSosText("Alerta Programada"),
                            MSosMultiOptionButton(
                                width: 180,
                                text: state.selectedAlert == null ? "" : state.selectedAlert!.name,
                                callbackFunction: () {
                                  selectAlertPopUpMenu.showPopUpMenu(context);
                                }),
                            const SizedBox(height: 20),
                            const MSosText("Grupo Programado"),
                            MSosMultiOptionButton(
                                width: 180,
                                text: state.selectedGroup == null ? "" : state.selectedGroup!.name,
                                callbackFunction: () {
                                  selectGroupPopUpMenu.showPopUpMenu(context);
                                }),
                            const SizedBox(height: 20),
                            const MSosText("Días a repetir"),
                            const SizedBox(height: 4),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: ToggleButtons(
                                direction: Axis.horizontal,
                                onPressed: (int index) {
                                  // All buttons are selectable.
                                  setState(() {
                                    state.selectedDays[index] = !state.selectedDays[index];
                                  });
                                },
                                borderRadius: const BorderRadius.all(Radius.circular(30)),
                                selectedBorderColor: MSosColors.blueDark,
                                selectedColor: Colors.white,
                                fillColor: MSosColors.blue,
                                color: MSosColors.grayMedium,
                                constraints: const BoxConstraints(
                                  minHeight: 40.0,
                                  minWidth: 80.0,
                                ),
                                isSelected: state.selectedDays,
                                children: state.days,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const MSosText("Hora a la que se activa"),
                            MSosMultiOptionButton(
                                text:
                                    "${state.targetRoutine.startTime['hour'].toString().padLeft(2, '0')}:${state.targetRoutine.startTime['min'].toString().padLeft(2, '0')}",
                                callbackFunction: () => {selectTimePopUpMenu.showPopUpMenu(context)},
                                width: 100)
                          ]),
                    ],
                  ),
                ),
              ),
            )));
  }
}
