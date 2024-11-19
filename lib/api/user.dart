class User {
  String? username;
  final String? _password;
  DateTime? dateRegistered;
  List<String> history = [];

  User(String this.username, String this._password,
      DateTime this.dateRegistered);

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
      print("Empty String!");
      return false;
    }
    print("$e added to $username's history!");
    history.add(e);
    return true;
  }

  bool removeHistory(String e) {
    if (e == "" || e == " ") {
      print("Empty String!");
      return false;
    }
    print("$e removed from $username's history!");
    history.remove(e);
    return true;
  }

  bool clearHistory() {
    if (history.isNotEmpty) {
      print("cleared $username's history!");
      history.clear();
      return true;
    }
    print("User does not have a history!");
    return false;
  }
}
