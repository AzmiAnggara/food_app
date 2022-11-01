// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class AppFormat {
  static String date(String stringDate) {
    // 2022-02-09
    DateTime dateTime = DateTime.parse(stringDate);
    return DateFormat('d MMM yyyy', 'id-ID').format(dateTime);
  }

  static String currency(String number) {
    return NumberFormat.currency(
      decimalDigits: 0,
      locale: 'id-ID',
      symbol: 'Rp ',
    ).format(double.parse(number));
  }
}
