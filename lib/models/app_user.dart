class AppUser {
  static bool isRegistered = false;
  static String name = '';
  static String email = '';
  static String password = '';

  static void register({
    required String name,
    required String email,
    required String password,
  }) {
    AppUser.name = name;
    AppUser.email = email;
    AppUser.password = password;
    isRegistered = true;
  }

  static bool checkCredentials(String email, String password) {
    return isRegistered &&
        email.toLowerCase() == AppUser.email.toLowerCase() &&
        password == AppUser.password;
  }
}
