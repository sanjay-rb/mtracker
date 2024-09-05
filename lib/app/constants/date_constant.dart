import 'package:intl/intl.dart';

class DateConstant {
  static DateFormat dateTimeFormat = DateFormat("yyyy-MM-dd hh:mm:ss a");
  static DateFormat dateformat = DateFormat("yyyy-MM-dd");
  static DateFormat timeformat = DateFormat("hh:mm:ss a");

  static DateTime dateStringToDateTime(String dateString) {
    return dateTimeFormat.parse(dateString);
  }

  static String dateTimeToDateString(DateTime dateTime) {
    return dateTimeFormat.format(dateTime);
  }
}
