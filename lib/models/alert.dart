// This class is the  model used for all the configured alarms.
class Alert {
  final int? id;
  final String name;
  final String message;
  final int? toleranceTime; // This value can be null as is overrided by each of the specified on the triggers
  final bool shareLocation; // Share location will be disactivated by default
  final Map<String, dynamic> triggers; // Only "basic" triggers are activated by default (button and disconnection)

  static const backtapTrigger = 'backtap_trigger';
  static const buttonTrigger = 'button_trigger';
  static const voiceTrigger = 'voice_trigger';
  static const internetDisconnectionTrigger = 'disconnection_trigger';
  static const smartwatcTrigger = 'smartwatch_trigger';
  static const smartwatchDisconnectionTrigger = 'smartwatch_disconnection_trigger';

  const Alert(
      {required this.id,
      required this.name,
      required this.message,
      this.toleranceTime,
      this.shareLocation = false,
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
      {'id': id, 'name': name, 'message': message, 'toleranceTime': toleranceTime, 'shareLocation': shareLocation, 'triggers': triggers};

  factory Alert.fromJson(Map<String, dynamic> data) {
    final int id = data['id'];
    final String name = data['name'];
    final String message = data['message'];
    final int toleranceTime = data['toleranceTime'];
    final bool shareLocation = data['shareLocation'];
    final Map<String, dynamic> triggers = data['triggers'];

    return Alert(id: id, name: name, message: message, toleranceTime: toleranceTime, shareLocation: shareLocation, triggers: triggers);
  }
}
