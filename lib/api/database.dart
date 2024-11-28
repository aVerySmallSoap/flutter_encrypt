import 'dart:collection';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:test_app/api/session.dart';
import 'package:test_app/api/user.dart';

//TODO: Convert into API calls that returns something
class Database {
  static File? _file;
  static List<dynamic>? _users = [];
  static LinkedHashMap<String, User> table = LinkedHashMap();

  static Future<File> getJSON() async {
    try {
      Directory? dir = await getApplicationDocumentsDirectory();
      return File('${dir.path}/users.json');
    } catch (e) {
      return File('./lib/db/users.json');
    }
  }

  /// Initializes the DB into the User class for in-client persistence.
  /// Always call the initialize function when starting the app
  static void init() async {
    try {
      _file = await getJSON();
      String? json = _file?.readAsStringSync();
      if (json != "") {
        _users = jsonDecode(json!);
        _users?.forEach((user) {
          User temp = User(user["username"], user["password"],
              DateTime.parse(user["registrationDate"]));
          table.addEntries({MapEntry(user["username"], temp)});
        });
      }
      return;
    } catch (e) {
      stdout.write("File not found! Creating file"); // log this line
    }
    return;
  }

  static void add(String username, String password) async {
    User temp = User(username, password, DateTime.now());
    table.addEntries({MapEntry(username, temp)});
    Map<String, dynamic> user = {};
    user["username"] = username;
    user["password"] = password;
    user["registrationDate"] = DateTime.now().toString();
    user["history"] = <String>[];
    _users?.add(user);
    return;
  }

  ///Call when user logs out
  static void exit() {
    if (_users!.isNotEmpty) {
      _users?.clear();
    }
    table.forEach((k, v) {
      if (k == Session.user?.username) {
        v = Session.user!;
      }
      _users?.add(v.toJson());
    });
    writeToDB();
  }

  ///API to write into the DB using the User class
  static Future<bool> writeToDB([String? json]) async {
    try {
      json ??= jsonEncode(_users);
      IOSink? fw = _file?.openWrite();
      fw?.write(json);
      await fw?.flush();
      await fw?.close();
    } catch (e) {
      stdout.write(
          '[${DateTime.now().toString()}][ERROR]: Something went wrong writing to file!\n');
      stdout.write(e);
      return false;
    }
    return true;
  }
}
