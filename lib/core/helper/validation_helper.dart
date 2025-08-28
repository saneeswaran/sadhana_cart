class ValidationHelper {
  static String? Function(String?)? validateTextField({required String text}) {
    if (text.isEmpty) {
      return (value) => 'Please enter $text';
    } else {
      return null;
    }
  }

  static String? Function(String?)? emailValidate() {
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return 'Please enter an email';
      } else if (!emailRegex.hasMatch(value.trim())) {
        return 'Please enter a valid email';
      }
      return null;
    };
  }

  static String? Function(String?)? passwordValidate({required int number}) {
    if (number >= 8) {
      return (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter a password';
        } else if (value.length != 8) {
          return 'Please enter a valid password';
        }
        return null;
      };
    }
    return null;
  }
}
