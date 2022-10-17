import 'package:intl/intl.dart';

String formatedDateTime(DateTime date) {
  return DateFormat('dd.MM.yyyy').format(date);
}
