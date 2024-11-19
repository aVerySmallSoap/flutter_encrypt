import 'dart:io';

import 'Users.dart';

class Registration {
  static void register(String username, String password) {
    if (Users.table.containsKey(username)) {
      print("Username is already taken!");
      return;
    }
    Users.add(username, password);
    Users.writeToDB();
  }
}
