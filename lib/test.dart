import 'package:test_app/api/database.dart';
import 'package:test_app/api/login.dart';
import 'package:test_app/api/registration.dart';

import 'Cipher.dart';

void main() async {
  // Database.init();
  // print(Login.login('tas', 'p'));
  // print(await Registration.register('tas', 'p'));
  print(Cipher.encrypt.vigenere('cheese', 'key'));
  print(Cipher.decrypt.vigenere('mlcowc', 'key'));
}
