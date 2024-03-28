import 'package:intl/intl.dart';

extension DateFormatExtension on DateTime {
  String completeDate() => DateFormat.yMd().add_jm().format(this);

  String toDate() {
    return toLocal().toString().split(' ')[0];
  }
}
