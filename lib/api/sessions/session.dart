import 'package:test_app/api/user.dart';

import 'crumbs.dart';

class Session {
  String name;
  User? user;
  DateTime sessionDate;
  int crumbID = 0;
  Map<int, Crumbs> localCrumbs = {};

  Session({required this.name, required this.user, required this.sessionDate});

  void sprinkle(Object o) {
    Crumbs c = Crumbs(
      id: crumbID,
      data: o,
    );
    localCrumbs.addEntries({MapEntry(crumbID, c)});
    ++crumbID;
    return;
  }

  Crumbs getCrumb(int index) {
    return localCrumbs[index]!;
  }

  void bite(int index) {
    localCrumbs.remove(index);
    return;
  }
}
