part of 'alert_menu_bloc.dart';

sealed class AlertMenuEvent extends Equatable {
  const AlertMenuEvent();

  @override
  List<Object> get props => [];
}

// To detect when comming from Alert List -> Create Alert
class InitialCreateAlertEvent extends AlertMenuEvent {
  final BuildContext context; // We Need the context for routing with Navigation.PushNamed() func
  const InitialCreateAlertEvent({required this.context});
}

// To edit an alert we need to read the value of the id to change it on the database.
class GetAlertEvent extends AlertMenuEvent {
  final BuildContext context; // We Need the context for routing with Navigation.PushNamed() func
  final Alert alert;
  const GetAlertEvent({required this.context, required this.alert});
}

// To update an alert when pressing save from the Alert Menu Screen with the new parameters
class UpdateAlertEvent extends AlertMenuEvent {
  final Alert alert;
  const UpdateAlertEvent({required this.alert});
}

// To create an alert when pressing the create button after filling the formulary on Alert Menu Screen
class CreateAlertEvent extends AlertMenuEvent {
  final Alert alert;
  const CreateAlertEvent({required this.alert});
}

// To update the multi option cupertino widget to select the tolerance time on the Alert Menu Screen
class ChangeToleranceTimeOptionEvent extends AlertMenuEvent {
  final int toleranceTimeOption;
  const ChangeToleranceTimeOptionEvent({required this.toleranceTimeOption});
}
