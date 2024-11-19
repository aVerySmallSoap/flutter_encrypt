import 'package:test_app/api/users.dart';
import 'package:test_app/api/login.dart';
import 'package:test_app/api/registration.dart';

void main() async {
  Users.init();
  print(Login.login('', ''));
}
