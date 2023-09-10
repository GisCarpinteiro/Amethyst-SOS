import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'trigger_config_state.dart';
part 'trigger_config_event.dart';

class TriggerConfigBloc extends Bloc<TriggerConfigEvent, TriggerConfigState> {
  TriggerConfigBloc() : super(const TriggerConfigInitialState()) {
    //Used to only update if the trigger is enabled for all alerts
    on<UpdateTriggerEnabledConfig>(
        (event, emit) => emit(TriggerConfigSetEnabledState(event.globalyEnabled)));

    //Used to update every value on the trigger
    on<UpdateVoiceCommandTriggerConfig>((event, emit) =>
        emit(TriggerConfigSetState(event.isEnabled, event.toleranceTime, event.voiceCommand)));
  }
}
