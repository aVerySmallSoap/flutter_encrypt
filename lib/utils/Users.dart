import 'dart:io';
import 'dart:convert';

class Users {
  static final File _file = File('${Directory.current.path}/lib/db/users.json');
  static List<dynamic>? users;

  static void init() async {
    String json = await _file.readAsString();
    if (json != "") {
      users = jsonDecode(json);
    }
    return;
  }

  static void add(String username, String password) {
    Map<String, dynamic> u = {};
    u["username"] = username;
    u["password"] = password;
    users?.add(u);
    return;
  }
}
