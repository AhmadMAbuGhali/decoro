extension DateExt on DateTime {
  String get toShortDate =>
      "${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";

  String get toReadable =>
      "$day/${month.toString().padLeft(2, "0")}/$year";

  String get toTime => "${hour.toString().padLeft(2, "0")}:${minute.toString().padLeft(2, "0")}";

  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;
}