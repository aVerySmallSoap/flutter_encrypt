import 'database.dart';

//TODO: Convert into API calls that returns something
class Login {
  static Map<String, dynamic> login(String username, String password) {
    if (Database.table.containsKey(username)) {
      bool logged = false;
      Database.table.forEach((k, v) {
        if (username == k && password == v.getPassword()) {
          logged = true;
          return;
        }
      });
      if (!logged) {
        return {"status": "error", "message": "Incorrect password"};
      }
      return {"status": "success", "message": "Login successful"};
    }
    if (!Database.table.containsKey(username) && password != "") {
      return {"status": "error", "message": "User does not exist"};
    }
    return {"status": "error", "message": "Incomplete fields"};
  }
}
