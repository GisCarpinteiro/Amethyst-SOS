class Routine {
  final int? id;
  final String name;
  final int alertId;
  final int groupId;
  final Map<String, dynamic> days;
  final Map<String, dynamic> startTime;
  final Map<String, dynamic>? endTime;

  Routine({
    this.id,
    required this.name,
    required this.alertId,
    required this.groupId,
    this.days = const {
      'monday': true,
      'tuesday': true,
      'wednesday': true,
      'thursdat': true,
      'friday': true,
      'saturday': false,
      'sunday': false,
    },
    this.startTime = const {
      'hour': '00',
      'min': '00',
    },
    this.endTime = const {
      'hour': '01',
      'min': '00',
    },
  });

  Map toJson() => {
        'id': id,
        'name': name,
        'alert': alertId,
        'group': groupId,
        'days': days,
        'start_time': startTime,
        'end_time': endTime,
      };

  factory Routine.fromJson(Map<String, dynamic> data) {
    final int id = data['id'];
    final String name = data['name'];
    final int alertId = data['alert_id'];
    final int groupId = data['group_id'];
    final Map<String, dynamic> days = data['days'];
    final Map<String, dynamic> startTime = data['start_time'];
    final Map<String, dynamic> endTime = data['end_time'];
    return Routine(id: id, name: name, alertId: alertId, groupId: groupId, days: days, startTime: startTime, endTime: endTime);
  }
}
