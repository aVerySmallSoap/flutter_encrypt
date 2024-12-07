import 'dart:collection';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:test_app/api/sessions/session_manager.dart';
import 'package:test_app/api/user.dart';

class Database {
  static File? _file;
  static List<dynamic>? _users = [];
  static LinkedHashMap<String, User> table = LinkedHashMap();

  static Future<File> getJSON() async {
    try {
      if (Platform.isAndroid) {
        Directory? dir = await getApplicationDocumentsDirectory();
        return File('${dir.path}/users.json');
      } else {
        return File('./lib/db/users.json');
      }
    } catch (e) {
      stdout.writeln(
          "Something happened and we don't know what! ${e.runtimeType}");
      stdout.writeln("Defaulting to relative storage...");
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
          List<dynamic> uHist = user["history"];
          List<String> tList = List.empty(growable: true);
          User temp = User(user["username"], user["password"],
              DateTime.parse(user["registrationDate"]));
          for (var e in uHist) {
            tList.add(e);
          }
          temp.replaceHistory(tList);
          table.addEntries({MapEntry(user["username"], temp)});
        });
      }
      return;
    } catch (e) {
      stdout.writeln("${e.runtimeType}");
      stdout.writeln("Something went wrong."); // log this line
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

  static void exit() {
    User? temp = SessionManager.instance.getSession(0)?.user;
    if (_users!.isNotEmpty) {
      _users?.clear();
    }
    table.forEach((k, v) {
      if (k == temp?.username) {
        v = temp!;
      }
      _users?.add(v.toJson());
    });
    writeToDB();
  }

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
