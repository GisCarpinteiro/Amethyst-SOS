// This enum let us define in which state the selected alert is and react to it.
enum AlertState { disabled, inactive, active, waiting }
// The meaning of each status is:
// * disabled: when the Alert Service hasn't been started, the status of the alert cannot be changed to any other than disabled which means that it cannot be activated by any chance
// * inactive: this status is acquired when the alert has been picked to start the Alert Service, and now is able to transition to the other two states or to disabled again if Alert Service is turned off.
// * waiting: this status is aquired if some activator send a signal to activate the alert, the Service will wait for the activation time to finish to fully activate the alert transitioning to active status or to inactive if it's cancelled while waiting.
// * active: once the tolerance time for desactivation finishes the alert is now active and the messages will start to send to the configured contacts as defined on the alert config. on this state different actions take place before going to inactive or disabled again.

// TODO: Discutir sobre la lógica de cómo debemos operar ante una alerta, bloqueo de reactivaciones, proceso de desactivación, etc. Esta es una versión inicial del servicio con una lógica que puede no tener en consideración todas las situaciones posibles.

// This class is the  model used for all the configured alarms.
class Alert {
  final int? id;
  final String name;
  final String message;
  final int toleranceSeconds; // This value can be null as is overrided by each of the specified on the triggers
  final bool shareLocation; // Share location will be disactivated by default
  final Map<String, dynamic> triggers; // Only "basic" triggers are activated by default (button and disconnection)

  static const backtapTrigger = 'backtap_trigger';
  static const buttonTrigger = 'button_trigger';
  static const voiceTrigger = 'voice_trigger';
  static const internetDisconnectionTrigger = 'disconnection_trigger';
  static const smartwatcTrigger = 'smartwatch_trigger';
  static const smartwatchDisconnectionTrigger = 'smartwatch_disconnection_trigger';

  const Alert(
      {this.id,
      required this.name,
      required this.message,
      this.toleranceSeconds = 30,
      this.shareLocation = true,
      this.triggers = const {
        buttonTrigger: true,
        backtapTrigger: false,
        voiceTrigger: false,
        internetDisconnectionTrigger: true,
        smartwatcTrigger: false,
        smartwatchDisconnectionTrigger: false,
      }});

  // Using jsonEncode(object) creates a String on JSON format as it follows:
  Map toJson() =>
      {'id': id, 'name': name, 'message': message, 'tolerance_seconds': toleranceSeconds, 'triggers': triggers};

  factory Alert.fromJson(Map<String, dynamic> data) {
    final int id = data['id'];
    final String name = data['name'];
    final String message = data['message'];
    final int toleranceSeconds = data['tolerance_seconds'];
    final Map<String, dynamic> triggers = data['triggers'];

    return Alert(id: id, name: name, message: message, toleranceSeconds: toleranceSeconds, triggers: triggers);
  }
}
