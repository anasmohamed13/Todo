import 'package:intl/intl.dart';

extension TimeExtension on DateTime {
  String get toFormatteDate {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    return dateFormat.format(this);
  }
}
