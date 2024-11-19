import 'users.dart';

//TODO: Convert into API calls that returns something
class Login {
  // Unpack all the data from json here
  static bool login(String username, String password) {
    if (Users.table.containsKey(username)) {
      bool logged = false;
      Users.table.forEach((k, v) {
        if (username == k && password == v["password"]) {
          logged = true;
          return;
        }
      });
      if (!logged) {
        print("Incorrect password!");
        return false;
      }
      return logged;
    }
    print("Incomplete Fields!");
    return false;
  }
}
