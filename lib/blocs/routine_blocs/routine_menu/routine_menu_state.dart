part of 'routine_menu_bloc.dart';

sealed class RoutineMenuState extends Equatable {
  final bool isEditionContext;
  final Routine? routine;
  final String alertName;
  final String groupName;

  const RoutineMenuState({this.isEditionContext = false, this.routine, this.alertName = "", this.groupName = ""});

  @override
  List<Object> get props => [];
}

// * This state just sets the defaults
final class RoutineMenuInitial$ extends RoutineMenuState {}

// * This state sets the values for the creation of a new Routine
final class SetNewRoutineContext$ extends RoutineMenuState {
  const SetNewRoutineContext$({super.isEditionContext = false, super.alertName = "", super.groupName = ""});
}

// * This state sets the values for the edition of an already existing Routine.
final class SetEditRoutineContext$ extends RoutineMenuState {
  const SetEditRoutineContext$({required super.routine, required super.alertName, required super.groupName, super.isEditionContext = true});
}
