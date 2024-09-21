class Validators {
  static String? emailValidator(String? data) {
    if (data!.isEmpty) {
      return 'email is required';
    } else if (data.contains('@') == false) {
      return 'email is not valid';
    }
    return null;
  }

  static String? passwordValidator(String? data) {
    if (data!.isEmpty) {
      return 'password is required';
    } else if (data.length < 7) {
      return 'password is too short';
    }
    return null;
  }
}
