class Validators {
  static bool isValidPhone(String value) {
    final normalized = value.replaceAll(RegExp(r'[^\d+]'), '');
    return RegExp(r'^\+?[1-9]\d{7,14}$').hasMatch(normalized);
  }
}
