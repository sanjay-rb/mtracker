import 'package:intl/intl.dart';

class DateConstant {
  static DateFormat dateTimeFormat = DateFormat("dd-MM-yyyy hh:mm a");
  static DateFormat dateformat = DateFormat("dd-MM-yyyy");
  static DateFormat timeformat = DateFormat("hh:mm a");

  static DateTime dateStringToDateTime(String dateString) {
    return dateTimeFormat.parse(dateString);
  }

  static String dateTimeToDateString(DateTime dateTime) {
    return dateTimeFormat.format(dateTime);
  }

  static String generateID() {
    DateTime dateTime = DateTime.now();
    DateFormat format = DateFormat("yyyyMMddHHmmss");
    return format.format(dateTime);
  }
}
