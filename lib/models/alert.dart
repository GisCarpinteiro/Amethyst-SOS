// This class is the  model used for all the configured alarms.

class Alert {
  final int id;
  final String name;
  final String message;
  final int? toleranceTime; // This value can be null as is overrided by each of the specified on the triggers
  final bool shareLocation; // Share location will be disactivated by default
  final Object triggers; // Only "basic" triggers are activated by default (button and disconnection)

  const Alert(
      {required this.id,
      required this.name,
      required this.message,
      this.toleranceTime,
      this.shareLocation = false,
      this.triggers = const {
        'button_trigger': true,
        'backtap_trigger': false,
        'voice_trigger': false,
        'disconnection_trigger': true,
        'smartwatch_trigger': false,
        'smartwatch_disonnection_trigger': false,
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
    final Object triggers = data['triggers'];

    return Alert(id: id, name: name, message: message, toleranceTime: toleranceTime, shareLocation: shareLocation, triggers: triggers);
  }
}
