import 'database.dart';

//TODO: Convert into API calls that returns something
class Login {
  // Unpack all the data from json here
  static Map<String, dynamic> login(String username, String password) {
    Map<String, dynamic> returnable;
    if (Database.table.containsKey(username)) {
      bool logged = false;
      Database.table.forEach((k, v) {
        if (username == k && password == v.getPassword()) {
          logged = true;
          return;
        }
      });
      if (!logged) {
        return returnable = {
          "status": "error",
          "message": "Incorrect password"
        };
      }
      return returnable = {"status": "success", "message": "Login successful"};
    }
    return returnable = {"status": "error", "message": "Incomplete fields"};
  }
}
