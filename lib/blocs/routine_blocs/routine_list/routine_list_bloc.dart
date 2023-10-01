import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vistas_amatista/controller/routines_controller.dart';
import 'package:vistas_amatista/models/routine.dart';

part 'routine_list_event.dart';
part 'routine_list_state.dart';

class RoutineListBloc extends Bloc<RoutineListEvent, RoutineListState> {
  RoutineListBloc() : super(const RoutineListInitial$()) {
    // * We handle this event by fetching the configured routines from local data (Shared Preferences) or firebase if local doesn't have them
    on<GetRoutineListEvent>((event, emit) {
      List<Routine> storedRoutines = RoutineController
          .getRoutines(); // ! Here a condition is needed to check if shared preferences had the list as null so a restore from DB is needed
      emit(const RoutineListInitial$()); // ! This one is used to ensure the reset of the state making the routines list  = []
      emit(SetRoutineList$(routines: storedRoutines));
    });
  }
}
