part of 'routine_list_bloc.dart';

sealed class RoutineListEvent extends Equatable {
  const RoutineListEvent();

  @override
  List<Object> get props => [];
}

class GetRoutineListEvent extends RoutineListEvent{
  // * This event doesn't receive parameters since the info is obtained from shared preferences or firebase and no from the Screen nor other variables, so it is just used to trigger the state inicialization.
  const GetRoutineListEvent();
}
