import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vistas_amatista/providers/routine_provider.dart';
import 'package:vistas_amatista/resources/colors/default_theme.dart';
import 'package:vistas_amatista/resources/custom_widgets/custom_buttons/msos_multi_option_button.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_appbar.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_button.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_dashboard.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_formfield.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_option_card.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_pop_up_menu.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_snackbar.dart';
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

    state.isEditionContext ? routineNameController.text = state.routineName : "";

    selectGroupPopUpMenu = MSosPopUpMenu(context,
        title: "Grupos",
        formChildren: state.groups.map((group) {
          return MSosOptionCard(
            title: group.name,
            isSelected: state.selectedGroup != null ? (group.id == state.selectedGroup!.id) : false,
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
          SizedBox(
            height: 120,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDateTime: DateTime(0, 0, 0, state.selectedTime['hour']!, state.selectedTime['min']!),
              onDateTimeChanged: (DateTime value) =>
                  provider.updateStartTime({"hour": value.hour, "min": value.minute}),
            ),
          ),
        ],
      )
    ], acceptCallbackFunc: () {
      provider.refreshView();
      selectTimePopUpMenu.dismissPopUpMenu();
    });

    provider.getRoutineList();
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: const MSosAppBar(title: 'Rutinas', icon: FontAwesomeIcons.route),
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
                              state.isEditionContext ? state.routineName : "Crear Rutina",
                              style: MSosText.subtitleStyle,
                              icon: Icons.list,
                            ),
                            const SizedBox(height: 20),
                            MSosFormField(label: "Nombre de la Rutina", controller: routineNameController),
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
                                  minWidth: 40.0,
                                ),
                                isSelected: state.selectedDays,
                                children: state.days,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const MSosText("Hora a la que se activa"),
                            MSosMultiOptionButton(
                                text:
                                    "${state.selectedTime['hour'].toString().padLeft(2, '0')}:${state.selectedTime['min'].toString().padLeft(2, '0')}",
                                callbackFunction: () => {selectTimePopUpMenu.showPopUpMenu(context)},
                                width: 100),
                            const SizedBox(height: 10),
                            MSosButton(
                              text: "Guardar",
                              style: MSosButton.smallButton,
                              color: MSosColors.blue,
                              onPressed: () {
                                provider.saveRoutine(newRoutineName: routineNameController.text).then((response) {
                                  if (response != null) {
                                    MSosFloatingMessage.showMessage(context,
                                        message: response, type: MSosMessageType.alert);
                                  } else {
                                    Navigator.pushNamed(context, "/routine_list");
                                  }
                                });
                              },
                            )
                          ]),
                    ],
                  ),
                ),
              ),
            )));
  }
}
