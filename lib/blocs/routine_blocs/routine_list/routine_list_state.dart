part of 'routine_list_bloc.dart';

sealed class RoutineListState extends Equatable {
  final List<Routine> routines;

  const RoutineListState({required this.routines});

  @override
  List<Object> get props => [];
}

final class RoutineListInitial$ extends RoutineListState {
  const RoutineListInitial$() : super(routines: const []);
}

final class SetRoutineList$ extends RoutineListState {
  const SetRoutineList$({required super.routines});
}
