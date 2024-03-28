import 'package:intl/intl.dart';

extension DateFormatExtension on DateTime {
  String yMMMd() => DateFormat.yMMMd('es_US').format(this);
  // String hhmm() => DateFormat.jm('es_US').format(this);
  String hhmm() => DateFormat.yMd().add_jm().format(this);
}
