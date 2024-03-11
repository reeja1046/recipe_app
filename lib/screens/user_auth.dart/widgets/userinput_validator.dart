class InputValidator {
  static String? validateUsername(String username) {
    if (username.isEmpty) {
      return 'Username is required';
    } else if (username.length <= 3) {
      return 'Name should be more than 3 characters';
    }
    return null;
  }

  static String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email is required';
    }

    RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$',
    );

    if (!emailRegExp.hasMatch(email)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password is required';
    } else if (password.length < 7 || password.contains(' ')) {
      return 'Password should be at least 7 characters long, and no spaces are allowed';
    }
    return null;
  }
}
