import 'package:intl/intl.dart';

class Formatters {
  static String currency(num value) {
    final formatter = NumberFormat.currency(
      locale: 'en',
      symbol: '\$',
    );
    return formatter.format(value);
  }

  static String compactNumber(num value) {
    return NumberFormat.compact().format(value);
  }

  static String cleanDouble(double value) {
    return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
  }
}