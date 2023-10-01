import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:vistas_amatista/controller/alert_controller.dart';
import 'package:vistas_amatista/controller/group_controller.dart';
import 'package:vistas_amatista/models/alert.dart';
import 'package:vistas_amatista/models/group.dart';
import 'package:vistas_amatista/models/routine.dart';

part 'routine_menu_event.dart';
part 'routine_menu_state.dart';

class RoutineMenuBloc extends Bloc<RoutineMenuEvent, RoutineMenuState> {
  RoutineMenuBloc() : super(RoutineMenuInitial$()) {
    on<CreateRoutineEvent>((event, emit) {
      emit(const SetNewRoutineContext$());
      Navigator.pushNamed(event.context, '/routine_menu');
    });

    on<EditRoutineEvent>((event, emit) {
      Alert? alert = AlertController.getAlertById(event.routine.alertId);
      Group? group = GroupController.getGroupById(event.routine.groupId);
      if (alert != null && group != null) {
        emit(SetEditRoutineContext$(routine: event.routine, alertName: alert.name, groupName: group.name));
        Navigator.pushNamed(event.context, '/routine_menu');
      } else {
        FlutterLogs.logError('class: RoutineMenuBloc', 'method: EditRoutineEvent handler', "Unable to find the Group or Alert for this");
      }
    });
  }
}
