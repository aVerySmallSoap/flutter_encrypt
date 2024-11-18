import 'dart:io';

import 'Users.dart';

class Registration {
  static File db = File('${Directory.current.path}/lib/db/users.json');

  static void register(String username, String password) {
    if (Users.table.containsKey(username)) {
      print("Username is already taken!");
      return;
    }
    Users.add(username, password);
    Users.writeToDB();
  }
}
