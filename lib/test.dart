import 'api/database.dart';
import 'api/login.dart';

void main() async {
  Database.init();
  Map<String, dynamic> response = Login.login('tas', 'p');
  print(response["status"] == "success");
}
