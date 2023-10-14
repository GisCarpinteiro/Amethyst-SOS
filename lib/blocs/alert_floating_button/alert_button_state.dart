part of 'alert_button_bloc.dart';

sealed class AlertButtonState extends Equatable {
  final bool isServiceActive;
  const AlertButtonState(this.isServiceActive);

  @override
  List<Object> get props => [];
}

final class AlertButtonStateChanged extends AlertButtonState {
  const AlertButtonStateChanged(super.isServiceActive);
}
