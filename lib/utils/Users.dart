import 'dart:collection';
import 'dart:io';
import 'dart:convert';

class Users {
  static final File _file = File('${Directory.current.path}/lib/db/users.json');
  static List<dynamic>? _users = [];
  static LinkedHashMap<String, Map<String, dynamic>> table = LinkedHashMap();

  /// Always call the initialize function when starting the app to load users
  static void init() async {
    String json = _file.readAsStringSync();
    if (json != "") {
      _users = jsonDecode(json);
      _users?.forEach((user) {
        table.addEntries({MapEntry(user["username"], user)});
      });
    }
    return;
  }

  static void add(String username, String password) async {
    Map<String, dynamic> user = {};
    user["username"] = username;
    user["password"] = password;
    _users?.add(user);
    return;
  }

  static void writeToDB([String? json]) async {
    json ??= jsonEncode(_users);
    IOSink fw = _file.openWrite();
    fw.write(json);
    await fw.flush();
    await fw.close();
  }
}
