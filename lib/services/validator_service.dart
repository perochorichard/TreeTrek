class ValidatorService {
  // HTML5 standard email spec
  static bool emailValidator(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(email.trim());
  }

  // Minimum six characters, at least one uppercase letter, one lowercase letter and one number
  static bool passwordValidator(String pass) {
    return RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$")
        .hasMatch(pass);
  }

  static bool profileNameValidator(String name) {
    return RegExp(r"^[a-zA-Z0-9]+([_ -]?[a-zA-Z0-9])*$").hasMatch(name.trim());
  }
}
