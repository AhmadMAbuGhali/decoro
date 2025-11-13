extension DateExt on DateTime {
  String toShortDate() => '${this.year}-${this.month}-${this.day}';
}