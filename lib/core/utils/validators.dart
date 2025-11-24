class Validators {
  static bool isEmail(String value) {
    final regex = RegExp(r"^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,4}$");
    return regex.hasMatch(value);
  }

  static bool isPassword(String value) => value.length >= 6;

  static bool isPhone(String value) {
    final regex = RegExp(r'^\+?[0-9]{9,15}$');
    return regex.hasMatch(value);
  }

  static bool isNotEmpty(String value) => value.trim().isNotEmpty;
}