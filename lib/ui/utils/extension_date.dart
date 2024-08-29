import 'package:intl/intl.dart';

extension TimeExtension on DateTime {
  String get toFormatteDate {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    return dateFormat.format(this);
  }

  String get dayName {
    List<String> days = ['sat', 'sun', 'mon', 'tue', 'wed', 'thurs', 'fri'];

    return days[weekday - 1];
  }
}
