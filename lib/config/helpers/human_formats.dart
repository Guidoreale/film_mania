import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number) {
    final formattedNumber = NumberFormat.compact(
      locale: 'en_US',
    ).format(number * 1000);
    return formattedNumber;
  }

  // a function to format a number of a calification  to a human readable format
  static String calification(double number) {
    final formattedNumber = NumberFormat.compact(
      locale: 'en_US',
    ).format(number);
    return formattedNumber;
  }
}
