class User {
  String? username;
  final String? _password;
  DateTime? dateRegistered;
  List<String> history = [];

  User(String this.username, String this._password,
      DateTime this.dateRegistered);

  Map<String, dynamic> toJson([User? u]) => {
        "username": u?.username ?? username,
        "password": u?._password ?? _password,
        "registrationDate":
            u?.dateRegistered.toString() ?? dateRegistered.toString(),
        "history": u?.history ?? history
      };

  String? getUsername() {
    return username;
  }

  String? getPassword() {
    return _password;
  }

  DateTime? getRegistrationDate() {
    return dateRegistered;
  }

  String? getRegistrationDateAsString() {
    return dateRegistered.toString();
  }

  List<String>? getHistory() {
    return history;
  }

  bool addHistory(String e) {
    if (e == "" || e == " ") {
      return false;
    }
    history.add(e);
    return true;
  }

  bool removeHistory(String e) {
    if (e == "" || e == " ") {
      return false;
    }
    history.remove(e);
    return true;
  }

  bool clearHistory() {
    if (history.isNotEmpty) {
      history.clear();
      return true;
    }
    return false;
  }
}
