import 'package:intl/intl.dart';

class Event {
  final String type;
  final String description;
  final String info1;
  final String info2;
  final String info3;
  final String info4;
  final String info5;
  late final String time;


  Event ({
    required this.type,
    required this.description,
    required this.info1,
    required this.info2,
    required this.info3,
    required this.info4,
    required this.info5,
  }) {
    DateTime timeNoFormat = DateTime.now();
    time = DateFormat('kk:mm:ss, MM-dd-yy').format(timeNoFormat);
  }

  Event.fromMap(Map<String, dynamic> data) :
        type = data['type'],
        description = data['description'],
        info1 = data['info1'],
        info2 = data['info2'],
        info3 = data['info3'],
        info4 = data['info4'],
        info5 = data['info5'],
        time = data['time'];

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'description': description,
      'info1': info1,
      'info2': info2,
      'info3': info3,
      'info4': info4,
      'info5': info5,
      'time': time,
    };
  }

  @override
  String toString() {
    return 'Event{time: $time, type: $type, description: $description}';
  }
}