import 'dart:io';
import 'users.dart';

//TODO: Convert into API calls that returns something
class Registration {
  static bool register(String username, String password) {
    if (username == "" || password == "") {
      print("Incomplete fields!");
      return false;
    }
    if (Users.table.containsKey(username)) {
      print("Username is already taken!");
      return false;
    }
    Users.add(username, password);
    Users.writeToDB();
    return true;
  }
}
