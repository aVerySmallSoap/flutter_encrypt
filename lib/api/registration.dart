import 'dart:io';
import 'database.dart';

//TODO: Convert into API calls that returns something
class Registration {
  static Future<bool> register(String username, String password) async {
    if (username == "" || password == "") {
      print("Incomplete fields!");
      return false;
    }
    if (Database.table.containsKey(username)) {
      print("Username is already taken!");
      return false;
    }
    Database.add(username, password);
    if (!await Database.writeToDB()) {
      return false;
    }
    return true;
  }
}
