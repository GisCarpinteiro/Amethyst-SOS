// EXPLANATION: these are the classes used for the models of the triggers configurated in the app
// CopyWith Methods create a copy of the instance

abstract class Trigger {
  bool globalyEnabled;
  final String type;
  int toleranceSeconds;

  Trigger(this.globalyEnabled, this.toleranceSeconds, {this.type = ''});

  void setGlobalyEnabled(bool globalyEnabled) {
    this.globalyEnabled = globalyEnabled;
  }

  void setToleranceSeconds(int toleranceSeconds) {
    this.toleranceSeconds = toleranceSeconds;
  }

  bool isGlobalyEnabled() {
    return globalyEnabled;
  }

  int getToleranceSeconds() {
    return toleranceSeconds;
  }
}

// Modelo para el activador por voz
class VoiceTrigger extends Trigger {
  final String safeWord;

  VoiceTrigger(super.globalyEnabled, super.toleranceSeconds, this.safeWord, {super.type = 'voice_trigger'});

  VoiceTrigger copyWith({bool? globalyEnabled, String? type, int? toleranceSeconds, String? safeWord}) {
    return VoiceTrigger(globalyEnabled ?? this.globalyEnabled, toleranceSeconds ?? this.toleranceSeconds, type: type ?? this.type, safeWord ?? this.safeWord);
  }
}

class BackTapTrigger extends Trigger {
  // Configuration to determine if the alert triggers with 2 or 3 taps, 2 by default
  final bool tripleTapEnabled;

  BackTapTrigger(super.globalyEnabled, super.toleranceSeconds, {this.tripleTapEnabled = false, super.type = 'backtap_trigger'});

  BackTapTrigger copyWith({bool? globalyEnabled, String? type, int? toleranceSeconds, bool? tripleTapEnabled}) {
    return BackTapTrigger(globalyEnabled ?? this.globalyEnabled, toleranceSeconds ?? this.toleranceSeconds, tripleTapEnabled: tripleTapEnabled ?? this.tripleTapEnabled, type: type ?? this.type);
  }
}

class SmartWatchTrigger extends Trigger {
  SmartWatchTrigger(super.globalyEnabled, super.toleranceSeconds, {super.type = 'smartwatch_trigger'});

  SmartWatchTrigger copyWith({bool? globalyEnabled, String? type, int? toleranceSeconds}) {
    return SmartWatchTrigger(globalyEnabled ?? this.globalyEnabled, toleranceSeconds ?? this.toleranceSeconds, type: type ?? this.type);
  }
}

class SmartWatchDisconnectionTrigger extends Trigger {
  SmartWatchDisconnectionTrigger(super.globalyEnabled, super.toleranceSeconds, {super.type = 'smartwatch_disconnection_trigger'});

  SmartWatchDisconnectionTrigger copyWith({bool? globalyEnabled, String? type, int? toleranceSeconds}) {
    return SmartWatchDisconnectionTrigger(globalyEnabled ?? this.globalyEnabled, toleranceSeconds ?? this.toleranceSeconds, type: type ?? this.type);
  }
}

class InternetDisconnectionTrigger extends Trigger {
  InternetDisconnectionTrigger(super.globalyEnabled, super.toleranceSeconds, {super.type = 'internet_disconnection_trigger'});

  InternetDisconnectionTrigger copyWith({bool? globalyEnabled, String? type, int? toleranceSeconds}) {
    return InternetDisconnectionTrigger(globalyEnabled ?? this.globalyEnabled, toleranceSeconds ?? this.toleranceSeconds, type: type ?? this.type);
  }
}

class ButtonTrigger extends Trigger {
  ButtonTrigger(super.globalyEnabled, super.toleranceSeconds, {super.type = 'button_trigger'});

  ButtonTrigger copyWith({bool? globalyEnabled, String? type, int? toleranceSeconds}) {
    return ButtonTrigger(globalyEnabled ?? this.globalyEnabled, toleranceSeconds ?? this.toleranceSeconds, type: type ?? this.type);
  }
}
