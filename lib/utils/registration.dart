import '../Cipher.dart';
import 'dart:io';
import 'dart:convert';

class Registration {
  static File db = File('${Directory.current.path}/lib/db/users.json');

  static void register(String username, String password) async {
    try {
      String json = await db.readAsString();
      IOSink w_db = db.openWrite();
      List<dynamic> users = [];
      if (json != "") {
        users = jsonDecode(json);
      }
      Map<String, dynamic> t = {};
      t["username"] = username;
      t["password"] = password;
      users.add(t);
      json = jsonEncode(users);
      w_db.write(json);
      await w_db.flush();
      await w_db.close();
    } catch (e) {
      print(e);
    }
  }
}
