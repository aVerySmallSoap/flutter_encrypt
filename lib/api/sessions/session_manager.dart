import 'package:test_app/api/sessions/session.dart';
import 'package:test_app/api/user.dart';

class SessionManager {
  SessionManager._();
  Map<String, Session> sessionStorage = {};
  static final SessionManager instance = SessionManager._();

  void createSession(String key, [User? user]) {
    Session s = Session(
      name: key,
      user: user,
      sessionDate: DateTime.now(),
    );
    sessionStorage.addEntries({MapEntry(key, s)});
    return;
  }

  void invalidateSession(String key) {
    sessionStorage.remove(key);
    return;
  }

  bool validateSession(String key) {
    return sessionStorage.containsKey(key); //Simpler implementation
  }

  Map<String, Session> getSessions() {
    return sessionStorage;
  }

  Session? getSession(String key) {
    return sessionStorage[key];
  }
}
