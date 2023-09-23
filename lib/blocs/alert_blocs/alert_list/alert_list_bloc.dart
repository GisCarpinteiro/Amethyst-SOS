import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vistas_amatista/controller/alert_controller.dart';
import 'package:vistas_amatista/models/alert.dart';

part 'alert_list_event.dart';
part 'alert_list_state.dart';

class AlertListBloc extends Bloc<AlertListEvent, AlertListState> {
  AlertListBloc() : super(GetAlertList$(AlertController.getAlerts())) {
    on<GetAlertsListEvent>((event, emit) {
      // We get the configured alerts from local data, if null we retry with remote database
      List<Alert> alertList = AlertController.getAlerts();
      emit(GetAlertList$(alertList));
    });

    on<CreateAlertEvent>((event, emit) {
      //We add a new alert to the list
      AlertController.addAlert(event.newAlert);
    });

    on<DeleteAlertEvent>((event, emit) {
      //We add a new alert to the list
      AlertController.deleteAlert(event.id);
    });
  }
}
