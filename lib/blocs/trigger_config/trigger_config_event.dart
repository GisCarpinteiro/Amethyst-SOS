part of 'trigger_config_bloc.dart';

@immutable
abstract class TriggerConfigEvent {}

class UpdateTriggerEnabledConfig extends TriggerConfigEvent {
  final bool globalyEnabled;
  UpdateTriggerEnabledConfig(this.globalyEnabled);
}

class UpdateVoiceCommandTriggerConfig extends TriggerConfigEvent {
  final bool isEnabled;
  final String voiceCommand;
  final int toleranceTime;

  UpdateVoiceCommandTriggerConfig(this.isEnabled, this.voiceCommand, this.toleranceTime);
}
