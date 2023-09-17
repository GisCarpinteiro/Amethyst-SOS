part of 'alert_list_bloc.dart';

sealed class AlertListState extends Equatable {
  final List<Alert> alerts;

  const AlertListState({required this.alerts});

  @override
  List<Object> get props => [];
}

// Initial state of the list is one without elements "[]"
final class AlertConfigInitial$ extends AlertListState {
  const AlertConfigInitial$() : super(alerts: const []);
}

// Event to Update alert list from database (local or remote)
final class GetAlertList$ extends AlertListState {
  const GetAlertList$(List<Alert> newAlertList) : super(alerts: newAlertList);
}
