import 'dart:collection';
import 'dart:io';
import 'dart:convert';

//TODO: Convert into API calls that returns something
class Database {
  static final File _file = File('${Directory.current.path}/lib/db/users.json');
  static List<dynamic>? _users = [];
  static LinkedHashMap<String, Map<String, dynamic>> table = LinkedHashMap();

  /// Initializes the DB into the User class for in-client persistence.
  /// Always call the initialize function when starting the app
  static void init() {
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

  ///API to write into the DB using the User class
  static Future<bool> writeToDB([String? json]) async {
    try {
      json ??= jsonEncode(_users);
      IOSink fw = _file.openWrite();
      fw.write(json);
      await fw.flush();
      await fw.close();
      return true;
    } catch (e) {
      print(DateTime.timestamp().toString());
      print('Something went wrong writing to file!');
      return false;
    }
  }
}
