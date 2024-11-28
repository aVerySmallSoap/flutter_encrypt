import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/utils/utility.dart';

void main() {
  group('Test for utility.dart', () {
    test('Test for string to numerics conversion', () {
      String s = 'ABC';
      List<int> out = Alphabets.toNumerics(s);
      expect(out, [0, 1, 2]);
    });
  });
}
