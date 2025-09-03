class StringHelper {
  static String maskCardNumber(String cardNumber) {
    final cleaned = cardNumber.replaceAll(RegExp(r'\s+'), '');
    if (cleaned.length < 4) return '****';

    final last4 = cleaned.substring(cleaned.length - 4);
    return '**** **** **** $last4';
  }
}
