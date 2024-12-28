String extractLocalNumber(String phoneNumber) {
  // Remove all non-digit characters (e.g., "+", "-", spaces)
  String digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

  // Get the last 10 digits
  return digitsOnly.length > 10
      ? digitsOnly.substring(digitsOnly.length - 10)
      : digitsOnly;
}
