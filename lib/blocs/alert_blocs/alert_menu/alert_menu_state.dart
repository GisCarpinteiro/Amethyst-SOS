part of 'alert_menu_bloc.dart';

sealed class AlertMenuState extends Equatable {
  final bool isAlertEditionContext;
  final int toleranceTimeOption;
  final Alert? alert;
  const AlertMenuState(
      {this.alert, this.isAlertEditionContext = false, this.toleranceTimeOption = 0});
  @override
  List<Object> get props => [];
}

final class setAlertFormState$ extends AlertMenuState{
  
}

final class InitialAlertContext$ extends AlertMenuState {
  const InitialAlertContext$();
}

final class ToleranceTimeSelection$ extends AlertMenuState {
  const ToleranceTimeSelection$(
      {required super.toleranceTimeOption});  
}

// The initial state used to create an alert doesn't needs info.
final class SetAlertCreationContext$ extends AlertMenuState {
  const SetAlertCreationContext$({super.isAlertEditionContext = false, super.alert});
}

// The State used to edit an alert requires an the EdtionContext set to true.
final class EditAlert$ extends AlertMenuState {
  const EditAlert$({required super.alert, super.isAlertEditionContext = true});
}
