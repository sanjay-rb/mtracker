import 'package:intl/intl.dart';

enum TransactionType { debit, credit, transfer }

String defaultCatagory = "🍔.Food";
String defaultFromAccount = "🏦.HDFC";
String defaultToAccount = "🚪.General";
TransactionType defaultTransactionType = TransactionType.debit;

String formatDateTime(DateTime when) {
  return DateFormat("dd-MMM-yyyy hh:mm:ss a").format(when);
}

String formatStringDateTime(String when) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
    ((double.parse(when) - 25569) * 86400000).toInt(),
    isUtc: true,
  );

  return DateFormat("dd-MMM-yyyy hh:mm:ss a (E)").format(dateTime);
}

String formatCurrency(double value) {
  var format = NumberFormat.currency(locale: 'HI');
  return format.format(value).replaceAll("INR", "");
}
