class User {
  String? username;
  DateTime? dateRegistered;
  List<String> history = [];

  String? getUsername() {
    return username;
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
    if (!history.isEmpty) {
      print("cleared $username's history!");
      history.clear();
      return true;
    }
    print("User does not have a history!");
    return false;
  }
}
