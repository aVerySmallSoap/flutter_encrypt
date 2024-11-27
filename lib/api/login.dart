import 'package:test_app/api/returnable.dart';
import 'package:test_app/api/session.dart';

import 'database.dart';

class Login {
  static Map<String, dynamic>? login(String username, String password) {
    if (username == "" && password == "") {
      return JSON(400, STATUS.badRequest, "Fill out all the fields!").build();
    }
    if (Database.table.containsKey(username)) {
      bool logged = false;
      Database.table.forEach((k, v) {
        if (username == k && password == v.getPassword()) {
          logged = true;
          SessionBuilder.initSession(v);
          return;
        }
      });
      if (!logged) {
        return JSON(400, STATUS.badRequest, "Incorrect password!").build();
      }
      return JSON(200, STATUS.OK, "Login successful!").build();
    }
    if (!Database.table.containsKey(username) && password != "") {
      return JSON(500, STATUS.internalError, "User does not exists!").build();
    }
    return JSON(400, STATUS.badRequest, "Incomplete fields!").build();
  }

  static void logout() {
    Database.exit();
    SessionBuilder.invalidateSession();
    return;
  }
}
