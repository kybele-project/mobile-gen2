import 'package:intl/intl.dart';

class Event {
  final String category;
  final String header;
  final String subHeader;
  final String interval;
  final int status;
  late final String date;
  late final String time;
  late final String primaryKey;

  Event({
    required this.category,
    required this.header,
    required this.subHeader,
    required this.interval,
    required this.status,
  }) {
    DateTime timeNoFormat = DateTime.now();
    date = DateFormat.yMMMMd('en_US').format(timeNoFormat);
    time = DateFormat.Hm().format(timeNoFormat);
    primaryKey =
        category + DateFormat('-MM-dd-yy-kk-mm-ss').format(timeNoFormat);
  }

  Event.fromMap(Map<String, dynamic> data)
      : category = data['category'],
        header = data['header'],
        subHeader = data['subHeader'],
        interval = data['interval'],
        status = data['status'],
        date = data['date'],
        time = data['time'],
        primaryKey = data['primaryKey'];

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'header': header,
      'subHeader': subHeader,
      'interval': interval,
      'status': status,
      'date': date,
      'time': time,
      'primaryKey': primaryKey,
    };
  }

  @override
  String toString() {
    return 'Event{primaryKey: $primaryKey, header: $header, subHeader: $subHeader}';
  }
}
