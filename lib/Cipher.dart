import 'utils/LinkedList.dart';
import 'package:test_app/utils/Utility.dart';
//TODO: Write documentation

/// The shift direction of the `caesar` algorithm.
enum Shift { left, right }

enum Mode { encrypt, decrypt }

abstract class Translator {
  /// Translates [word] with its bash counter-part.
  String? bash(String word);

  /// Translates [word] with its caesar counter-part.
  String? caesar(Shift dir, int shift, String word);

  /// Translates [word] with its vigenere counter-part using a [key].
  String? vigenere(String word, String key);

  /// Transforms a `String` into a [LinkedList] of [int].
  LinkedList<int> _key(String k) {
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

/// Static utility class that enables the usage of [Encrypt] and [Decrypt].
class Cipher {
  static final Encrypt encrypt = Encrypt();
  static final Decrypt decrypt = Decrypt();
}

/// Encrypts incoming [Strings] based on a implemented algorithm.
class Encrypt extends Translator {
  static final StringBuffer _sb = StringBuffer();

  @override
  String? bash(String word) {
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

  @override
  String? caesar(Shift dir, int shift, String word) {
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

  @override
  String? vigenere(String word, String key) {
    LinkedList<int> keyList = super._key(key);
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
}

/// Decrypts incoming [Strings] based on a implemented algorithm.
class Decrypt extends Translator {
  static final StringBuffer _sb = StringBuffer();

  @override
  String? bash(String word) {
    for (var i = 0; i < word.length; ++i) {
      for (var j = Alphabets.size - 1; j >= 0; --j) {
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

  @override
  String? caesar(Shift dir, int shift, String word) {
    // TODO: implement caesar
    throw UnimplementedError();
  }

  @override
  String? vigenere(String word, String key) {
    LinkedList<int> keyList = super._key(key);
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
      int sum = numeric[i] - parsed[i] % 26;
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
}
