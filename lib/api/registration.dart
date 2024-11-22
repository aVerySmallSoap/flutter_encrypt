import 'database.dart';

//TODO: Convert into API calls that returns something
class Registration {
  static Future<Map<String, dynamic>> register(
      String username, String password) async {
    if (username == "" || password == "") {
      return {"status": "error", "message": "Incomplete fields"};
    }
    if (Database.table.containsKey(username)) {
      return {"status": "error", "message": "Username already taken"};
    }
    Database.add(username, password);
    if (!await Database.writeToDB()) {
      return {"status": "error", "message": "Database write went wrong"};
    }
    return {"status": "success", "message": "Login successful"};
  }
}
