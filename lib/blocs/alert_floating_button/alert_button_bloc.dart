import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'alert_button_event.dart';
part 'alert_button_state.dart';

class AlertButtonBloc extends Bloc<AlertButtonEvent, AlertButtonState> {
  AlertButtonBloc() : super(const AlertButtonStateChanged(false)) {
    on<EnableAlertButton>((event, emit) {
      emit(const AlertButtonStateChanged(true));
    });
    on<DisableAlertButton>((event, emit) {
      emit(const AlertButtonStateChanged(false));
    });
  }
}
