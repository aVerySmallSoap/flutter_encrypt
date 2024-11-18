import 'utils/LinkedList.dart';
import 'package:test_app/utils/Utility.dart';
//TODO: Write documentation

enum Shift { left, right }

enum Mode { encrypt, decrypt }

class Cipher {
  static final StringBuffer _sb = StringBuffer();

  //TODO: Accept all special characters and print
  //TODO: Separate upper-case and lower-case letters
  static String? bash(String word) {
    for (int i = 0; i < word.length; ++i) {
      for (int j = 0; j < Alphabets.size; ++j) {
        if (Alphabets.ordered[j] == word[i].toUpperCase()) {
          _sb.write(Alphabets.ordered[Alphabets.size - (j + 1)]);
          break;
        }
      }
    }
    String? t = _sb.toString();
    _sb.clear();
    return t.toString();
  }

  //TODO: Accept all special characters and print
  //TODO: Separate upper-case and lower-case letters
  static String? caesar(Shift dir, int shift, String word) {
    dir == Shift.left ? shift *= -1 : shift;
    for (int i = 0; i < word.length; ++i) {
      for (int j = 0; j < Alphabets.size; ++j) {
        if (Alphabets.ordered[j] == word[i].toUpperCase()) {
          int sum = (j + shift) % 26;
          sum < 0 ? sum += 26 : sum;
          _sb.write(Alphabets.ordered[sum]);
          break;
        }
      }
    }
    String? t = _sb.toString();
    _sb.clear();
    return t.toString();
  }

  //TODO: Accept all special characters and print
  //TODO: Separate upper-case and lower-case letters
  static String? vigenere(String word, String key) {
    LinkedList<int> keyList = _key(key);
    Node<int>? ptr = keyList.head;
    List<int> parsed = List<int>.filled(word.length, 0);
    List<int> numeric = Alphabets.toNumerics(word);
    for (int i = 0; i < word.length; ++i) {
      if (numeric[i] == 32) continue;
      parsed[i] = ptr!.value;
      ptr = ptr.next as Node<int>?;
    }
    for (int i = 0; i < numeric.length; ++i) {
      if (numeric[i] == 32) {
        _sb.write(' ');
        continue;
      }
      int sum = numeric[i] + parsed[i] % 26;
      if (sum < 0) {
        sum += 26;
        _sb.write(Alphabets.ordered[sum]);
      } else if (sum >= 26) {
        sum -= 26;
        _sb.write(Alphabets.ordered[sum]);
      } else {
        _sb.write(Alphabets.ordered[sum]);
      }
    }
    String? cyphered = _sb.toString();
    _sb.clear();
    return cyphered;
  }

  static LinkedList<int> _key(String k) {
    LinkedList<int> parsed = LinkedList();
    for (int i = 0; i < k.length; ++i) {
      for (int j = 0; j < Alphabets.size; ++j) {
        if (Alphabets.ordered[j] == k[i].toUpperCase()) {
          parsed.insertLast(Alphabets.numerical[j]);
          break;
        }
      }
    }
    return parsed;
  }
}
