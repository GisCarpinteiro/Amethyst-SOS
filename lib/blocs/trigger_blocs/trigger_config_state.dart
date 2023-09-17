part of 'trigger_config_bloc.dart';

@immutable
abstract class TriggerConfigState {
  final bool isEnabled;
  final int toleranceTime;
  final String voiceCommand;

  const TriggerConfigState(
      {this.isEnabled = false, this.toleranceTime = 0, this.voiceCommand = 'amatista morada'});

  List<Object> get props => [isEnabled, toleranceTime, voiceCommand];
}

class TriggerConfigInitialState extends TriggerConfigState {
  const TriggerConfigInitialState()
      : super(isEnabled: false, toleranceTime: 0, voiceCommand: 'amatista morada');
}

class TriggerConfigSetEnabledState extends TriggerConfigState { 
  const TriggerConfigSetEnabledState(bool isEnabled) : super(isEnabled: isEnabled);
}

class TriggerConfigSetState extends TriggerConfigState {
  const TriggerConfigSetState(bool isEnabled, int toleranceTime, String voiceCommand)
      : super(isEnabled: isEnabled, toleranceTime: toleranceTime, voiceCommand: voiceCommand);
}
