part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}


class SetHomeStateEvent extends HomeEvent {
  
  final String selectedAlert; 
  final String selectedGroup; 
  final AlertState alertState;
  final bool isServiceEnabled;
  const SetHomeStateEvent({required this.isServiceEnabled, required this.selectedAlert, required this.selectedGroup, required this.alertState});
}

class SetSelectedAlertAndGroupEvent extends HomeEvent { 
  final String selectedAlert; 
  final String selectedGroup; 
  const SetSelectedAlertAndGroupEvent({required this.selectedAlert, required this.selectedGroup});
}

class SetServiceStateEvent extends HomeEvent { 
  final bool isServiceEnabled;
  const SetServiceStateEvent({required this.isServiceEnabled});
}

class SetActiveAlertStateEvent extends HomeEvent { 
  final AlertState alertState;
  const SetActiveAlertStateEvent({required this.alertState});
}