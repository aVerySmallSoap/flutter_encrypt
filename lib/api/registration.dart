import 'dart:io';
import 'database.dart';

//TODO: Convert into API calls that returns something
class Registration {
  static Future<Object> register(String username, String password) async {
    Map<String, dynamic> returnable;
    if (username == "" || password == "") {
      return returnable = {"status": "error", "message": "Incomplete fields"};
    }
    if (Database.table.containsKey(username)) {
      return returnable = {
        "status": "error",
        "message": "Username already taken"
      };
    }
    Database.add(username, password);
    if (!await Database.writeToDB()) {
      return returnable = {
        "status": "error",
        "message": "Database write went wrong"
      };
    }
    return {"status": "success", "message": "Login successful"};
  }
}
