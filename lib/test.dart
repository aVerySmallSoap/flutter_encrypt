import 'package:test_app/utils/Users.dart';
import 'package:test_app/utils/login.dart';

void main() async {
  Users.init();
  print(Login.login('test', 'pass'));
}
