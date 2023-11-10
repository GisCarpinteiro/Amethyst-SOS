class Routine {
  final int? id;
  final String name;
  final int alertId;
  final int groupId;
  final Map<String, dynamic> days;
  final Map<String, dynamic> startTime;
  final int durationMinutes;

  Routine(
      {this.id,
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
        'hour': 0,
        'min': 0,
      },
      this.durationMinutes = 0});

  Map toJson() => {
        'id': id,
        'name': name,
        'alert': alertId,
        'group': groupId,
        'days': days,
        'start_time': startTime,
        'duration_minutes': durationMinutes,
      };

  factory Routine.fromJson(Map<String, dynamic> data) {
    final int id = data['id'];
    final String name = data['name'];
    final int alertId = data['alert'];
    final int groupId = data['group'];
    final Map<String, dynamic> days = data['days'];
    final Map<String, dynamic> startTime = data['start_time'];
    final int durationMinutes = data['duration_minutes'];
    return Routine(
        id: id,
        name: name,
        alertId: alertId,
        groupId: groupId,
        days: days,
        startTime: startTime,
        durationMinutes: durationMinutes);
  }
}
