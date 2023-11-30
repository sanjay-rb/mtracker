import 'package:intl/intl.dart';

enum TransactionType { debit, credit, transfer }

String defaultCatagory = "🍔.Food";
String defaultFromAccount = "🏦.HDFC";
String defaultToAccount = "🚪.General";
TransactionType defaultTransactionType = TransactionType.debit;

String refreshGif =
    "https://cdn.dribbble.com/users/1864713/screenshots/10569127/media/5c55967e67316a13184d970c26e4a5c7.gif";

String formatDateTime(DateTime when) {
  return DateFormat("MM/dd/yyyy").format(when);
}

String formatStringDateTime(String when) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
    ((double.parse(when) - 25569) * 86400000).toInt(),
    isUtc: true,
  );

  return DateFormat("MM/dd/yyyy").format(dateTime);
}

String formatCurrency(double value) {
  var format = NumberFormat.currency(locale: 'HI');
  return format.format(value).replaceAll("INR", "");
}
