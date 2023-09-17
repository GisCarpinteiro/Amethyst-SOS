import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vistas_amatista/controller/alert_controller.dart';
import 'package:vistas_amatista/models/alert.dart';

part 'alert_menu_event.dart';
part 'alert_menu_state.dart';

class AlertMenuBloc extends Bloc<AlertMenuEvent, AlertMenuState> {
  AlertMenuBloc() : super(const InitialAlertContext$()) {
    // Comming from AlertList -> Create Alert
    on<InitialCreateAlertEvent>((event, emit) {
      emit(const SetAlertCreationContext$());
      Navigator.pushNamed(event.context, '/alert_menu');
    });
    // When pressing CREATE on AlertMenu Screen
    on<CreateAlertEvent>((event, emit) {
      // TODO: Test if working as intended on the Configuration JSON
      AlertController.addAlert(event.alert);
    });

    // Comming from AlertList -> Edit Alert:
    on<GetAlertEvent>((event, emit) {
      // For some reason I have to force the update by emiting the status tu null then to the selected alert
      emit(const SetAlertCreationContext$());
      emit(EditAlert$(alert: event.alert));
      Navigator.pushNamed(event.context, '/alert_menu');
    });

    // When Pressing Save button on Alert Menu with Alert Edition Context
    on<UpdateAlertEvent>((event, emit) {
      // TODO: Implement UpdateAlert on ConfigurationsJson locally and remotly.
    });

    on<ChangeToleranceTimeOptionEvent>((event, emit) {
      emit(ToleranceTimeSelection$(toleranceTimeOption: event.toleranceTimeOption));
    });
  }
}
