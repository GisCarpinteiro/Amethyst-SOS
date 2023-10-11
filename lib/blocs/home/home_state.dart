part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial$ extends HomeState {
  final bool isServiceEnabled; // Status needed to change the color an behavior of some widgets/elements on homescreen.
  final String selectedAlert; // Name of the actual alert picked by the multi option widget
  final String selectedGroup; // Name of the actual group picked on the multi option widget
  final AlertState alertState; // State of the alert (active, inactive, waiting, disable)
  final List<Alert> alerts;
  final List<Group> groups;

  const HomeInitial$({
    this.isServiceEnabled = false,
    this.selectedAlert = "",
    this.selectedGroup = "",
    this.alertState = AlertState.disabled,
    this.groups = const [],
    this.alerts = const [],
  });
  @override
  List<Object> get props => [isServiceEnabled, selectedAlert, selectedGroup, alertState, alerts, groups];
}

final class HomeGeneralState$ extends HomeState {
  final bool isServiceEnabled; // Status needed to change the color an behavior of some widgets/elements on homescreen.
  final String selectedAlert; // Name of the actual alert picked by the multi option widget
  final String selectedGroup; // Name of the actual group picked on the multi option widget
  final AlertState alertState; // State of the alert (active, inactive, waiting, disable)
  const HomeGeneralState$(
      {required this.isServiceEnabled, required this.alertState, required this.selectedAlert, required this.selectedGroup});
}

final class HomeSelectedGroupAndAlert$ extends HomeState {
  final String selectedAlert;
  final String selecteGroup;
  const HomeSelectedGroupAndAlert$({required this.selectedAlert, required this.selecteGroup});
}
