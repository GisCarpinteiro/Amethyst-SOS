part of 'alert_list_bloc.dart';

sealed class AlertListEvent extends Equatable {
  const AlertListEvent();

  @override
  List<Object> get props => [];
}

class GetAlertsListEvent extends AlertListEvent {
  const GetAlertsListEvent();
}

class CreateAlertEvent extends AlertListEvent {
  final Alert newAlert;
  const CreateAlertEvent(this.newAlert);
}

class DeleteAlertEvent extends AlertListEvent {
  final int id;
  const DeleteAlertEvent(this.id);
}
