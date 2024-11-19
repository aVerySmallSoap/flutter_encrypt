import 'dart:collection';
import 'dart:io';
import 'dart:convert';
import 'package:test_app/api/user.dart';

//TODO: Convert into API calls that returns something
class Database {
  static final File _file = File('${Directory.current.path}/lib/db/users.json');
  static List<dynamic>? _users = [];
  static LinkedHashMap<String, User> table = LinkedHashMap();

  /// Initializes the DB into the User class for in-client persistence.
  /// Always call the initialize function when starting the app
  static void init() {
    String json = _file.readAsStringSync();
    if (json != "") {
      _users = jsonDecode(json);
      _users?.forEach((user) {
        User temp = User(user["username"], user["password"],
            DateTime.parse(user["registrationDate"]));
        table.addEntries({MapEntry(user["username"], temp)});
      });
    }
    return;
  }

  static void add(String username, String password) async {
    Map<String, dynamic> user = {};
    user["username"] = username;
    user["password"] = password;
    user["registrationDate"] = DateTime.now().toString();
    user["history"] = <String>[];
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
    } catch (e) {
      print(DateTime.now());
      print('Something went wrong writing to file!');
      print(e);
      return false;
    }
    return true;
  }
}
