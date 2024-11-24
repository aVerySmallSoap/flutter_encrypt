import 'package:test_app/api/returnable.dart';

import 'database.dart';

//TODO: Convert into API calls that returns something
class Registration {
  static Future<Map<String, dynamic>?> register(
      String username, String password) async {
    if (username == "" || password == "") {
      return JSON(400, STATUS.badRequest, "Fill out all the fields!").build();
    }
    if (Database.table.containsKey(username)) {
      return JSON(400, STATUS.badRequest, "Username already taken!").build();
    }
    Database.add(username, password);
    if (!await Database.writeToDB()) {
      return JSON(500, STATUS.internalError, "Database write went wrong!")
          .build();
    }
    return JSON(200, STATUS.OK, "Registration successful!").build();
  }
}
