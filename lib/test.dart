import 'package:test_app/api/database.dart';
import 'package:test_app/api/login.dart';
import 'package:test_app/api/registration.dart';

void main() async {
  Database.init();
  print(Login.login('', ''));
}
