part of 'routine_menu_bloc.dart';

sealed class RoutineMenuEvent extends Equatable {
  const RoutineMenuEvent();

  @override
  List<Object> get props => [];
}

class EditRoutineEvent extends RoutineMenuEvent {
  final Routine routine;
  final BuildContext context;
  const EditRoutineEvent({required this.routine, required this.context});
}

// This event doesn't really need any parameters since all the values of the state are setted by default.
class CreateRoutineEvent extends RoutineMenuEvent {
  final BuildContext context;
  const CreateRoutineEvent({required this.context});
}

// TODO: Implementar los eventos para:
// * Update: Cuando se está en el contexto de edición y se presiona "Guardar Rutina"
// * Crear: Cuando se está en el contexto de creación y se presiona "Crear Rutina"
// ! Ambos son el mismo botón! solo que dependiendo del contexto el botón dispara un evento u otro.

