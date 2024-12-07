import 'package:test_app/api/sessions/session.dart';

import '../user.dart';

class SessionManager {
  SessionManager._();
  int assignable = 0;
  Map<int, Session> sessionStorage = {};
  static final SessionManager instance = SessionManager._();

  void createSession([User? user]) {
    Session s = Session(
      id: assignable,
      user: user,
      sessionDate: DateTime.now(),
    );
    sessionStorage.addEntries({MapEntry(assignable, s)});
    ++assignable;
    return;
  }

  void invalidateSession(int id) {
    sessionStorage.remove(id);
    return;
  }

  bool validateSession(int id) {
    return sessionStorage.containsKey(id); //Simpler implementation
  }

  Map<int, Session> getSessions() {
    return sessionStorage;
  }

  Session? getSession(int id) {
    return sessionStorage[id];
  }
}
