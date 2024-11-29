class User {
  String? username;
  final String? _password;
  DateTime? dateRegistered;
  List<String> _history = [];

  User(
    String this.username,
    String this._password,
    DateTime this.dateRegistered,
  );

  Map<String, dynamic> toJson([User? u]) => {
        "username": u?.username ?? username,
        "password": u?._password ?? _password,
        "registrationDate":
            u?.dateRegistered.toString() ?? dateRegistered.toString(),
        "history": u?._history ?? _history
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

  List<String> getHistory() {
    return _history;
  }

  void replaceHistory(List<String> list) {
    _history = list;
    return;
  }

  bool addHistory(String e) {
    if (e == "" || e == " ") {
      return false;
    }
    _history.add(e);
    return true;
  }

  bool removeHistory(String e) {
    if (e == "" || e == " ") {
      return false;
    }
    _history.remove(e);
    return true;
  }

  bool clearHistory() {
    if (_history.isNotEmpty) {
      _history.clear();
      return true;
    }
    return false;
  }
}
