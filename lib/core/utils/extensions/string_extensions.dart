extension StringExt on String {
  bool get isValidEmail {
    final regex = RegExp(r"^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,4}$");
    return regex.hasMatch(this);
  }

  bool get isStrongPassword =>
      length >= 8 && contains(RegExp(r'[A-Z]')) && contains(RegExp(r'[0-9]'));

  String get capitalize =>
      isEmpty ? this : this[0].toUpperCase() + substring(1);

  String get noSpaces => replaceAll(" ", "");
}