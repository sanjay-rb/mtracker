import 'package:intl/intl.dart';

String formatDateTime(String when) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
    ((double.parse(when) - 25569) * 86400000).toInt(),
    isUtc: true,
  );

  return DateFormat.yMEd().add_jms().format(dateTime);
}

String formatCurrency(double value) {
  var format = NumberFormat.currency(locale: 'HI');
  return format.format(value).replaceAll("INR", "");
}
