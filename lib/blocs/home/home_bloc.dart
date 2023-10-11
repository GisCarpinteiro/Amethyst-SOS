import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vistas_amatista/models/alert.dart';
import 'package:vistas_amatista/models/group.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial$()) {
    on<SetHomeStateEvent>((event, emit) {
      emit(HomeGeneralState$(
          isServiceEnabled: event.isServiceEnabled,
          alertState: event.alertState,
          selectedAlert: event.selectedAlert,
          selectedGroup: event.selectedGroup));
    });
  }
}
