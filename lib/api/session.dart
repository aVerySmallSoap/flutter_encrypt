import 'package:test_app/api/user.dart';

class SessionBuilder {
  static void initSession(User u) {
    Session.user = u;
    return;
  }

  static void invalidateSession() {
    Session.user = null;
    Session.sessionDate = null;
    return;
  }
}

class Session {
  static User? user;
  static DateTime? sessionDate = DateTime.now();
}
