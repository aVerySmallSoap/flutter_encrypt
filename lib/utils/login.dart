import 'Users.dart';

class Login {
  // Unpack all the data from json here
  static bool login(String username, String password) {
    if (Users.table.containsKey(username)) {
      bool logged = false;
      bool incorrect = false;
      Users.table.forEach((k, v) {
        if (username == k && password == v["password"]) {
          logged = true;
          return;
        } else {
          incorrect = true;
          return;
        }
      });
      if (incorrect) {
        print("Incorrect password!");
        incorrect = false;
        return false;
      }
      return logged;
    }
    return false;
  }
}
