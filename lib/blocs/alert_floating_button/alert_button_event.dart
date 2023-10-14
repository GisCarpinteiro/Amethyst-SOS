part of 'alert_button_bloc.dart';

sealed class AlertButtonEvent extends Equatable {
  const AlertButtonEvent();

  @override
  List<Object> get props => [];
}

class EnableAlertButton extends AlertButtonEvent {}

class DisableAlertButton extends AlertButtonEvent {}
