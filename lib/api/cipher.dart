import 'package:test_app/api/returnable.dart';
import 'package:test_app/utils/linked_List.dart';
import 'package:test_app/utils/utility.dart';

/// The shift direction of the `caesar` algorithm.
enum Shift { left, right }

enum Mode { encrypt, decrypt }

abstract class Translator {
  /// Translates [word] with its bash counter-part.
  Map<String, dynamic>? bash(String word);

  /// Translates [word] with its caesar counter-part.
  Map<String, dynamic>? caesar(Shift dir, int shift, String word);

  /// Translates [word] with its vigenere counter-part using a [key].
  Map<String, dynamic>? vigenere(String word, String key);

  /// Transforms a `String` into a [LinkedList] of [int].
  LinkedList<int> _key(String k) {
    LinkedList<int> parsed = LinkedList();
    for (int i = 0; i < k.length; ++i) {
      for (int j = 0; j < Alphabets.size; ++j) {
        if (Alphabets.upper_ordered[j] == k[i].toUpperCase()) {
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
  Map<String, dynamic>? bash(String word) {
    List<List<int>> resolved = Alphabets.stringToOrder(word);
    List<int> order = resolved[0];
    List<int> pos = resolved[1];
    for (int i = 0; i < order.length; ++i) {
      if (order[i] == 32) {
        _sb.write(" ");
        continue;
      } else if (order[i] == 1) {
        _sb.write(Alphabets.upper_ordered[26 - (pos[i] + 1)]);
        continue;
      } else if (order[i] == 2) {
        _sb.write(Alphabets.lower_ordered[26 - (pos[i] + 1)]);
        continue;
      } else {
        _sb.write(String.fromCharCode(pos[i]));
        continue;
      }
    }
    String? t = _sb.toString();
    _sb.clear();
    return JSON(200, STATUS.OK, "text ciphered")
        .addOptional(t.toString())
        .build();
  }

  @override
  Map<String, dynamic>? caesar(Shift dir, int shift, String word) {
    List<List<int>> resolved = Alphabets.stringToOrder(word);
    List<int> order = resolved[0];
    List<int> pos = resolved[1];
    dir == Shift.left ? shift *= -1 : shift;
    for (int i = 0; i < order.length; ++i) {
      int sum = (pos[i] + shift) % 26;
      if (order[i] == 32) {
        _sb.write(" ");
        continue;
      } else if (order[i] == 1) {
        _sb.write(Alphabets.upper_ordered[sum]);
        continue;
      } else if (order[i] == 2) {
        _sb.write(Alphabets.lower_ordered[sum]);
        continue;
      } else {
        _sb.write(String.fromCharCode(pos[i]));
        continue;
      }
    }
    String? t = _sb.toString();
    _sb.clear();
    return JSON(200, STATUS.OK, "text ciphered")
        .addOptional(t.toString())
        .build();
  }

  @override
  Map<String, dynamic>? vigenere(String word, String key) {
    List<List<int>> resolved = Alphabets.stringToOrder(word);
    List<int> order = resolved[0];
    List<int> pos = resolved[1];
    LinkedList<int> keyList = super._key(key);
    Node<int>? ptr = keyList.head;
    List<int> parsed = List<int>.filled(word.length, 0);
    for (int i = 0; i < word.length; ++i) {
      // repeat key till word length
      if (order[i] == 32 || order[i] == 0) continue;
      parsed[i] = ptr!.value;
      ptr = ptr.next as Node<int>?;
    }

    for (int i = 0; i < order.length; ++i) {
      int sum = pos[i] + parsed[i] % 26;
      if (order[i] == 32) {
        _sb.write(" ");
        continue;
      } else if (order[i] == 1) {
        _sumCheck(sum, Alphabets.upper_ordered);
        continue;
      } else if (order[i] == 2) {
        _sumCheck(sum, Alphabets.lower_ordered);
        continue;
      } else {
        _sb.write(String.fromCharCode(pos[i]));
        continue;
      }
    }

    String? ciphered = _sb.toString();
    _sb.clear();
    return JSON(200, STATUS.OK, "text ciphered")
        .addOptional(ciphered.toString())
        .build();
  }

  void _sumCheck(int sum, List<String> arr) {
    if (sum < 0) {
      sum += 26;
      _sb.write(arr[sum]);
      return;
    } else if (sum >= 26) {
      sum -= 26;
      _sb.write(arr[sum]);
      return;
    } else {
      _sb.write(arr[sum]);
      return;
    }
  }
}

class Decrypt extends Translator {
  static final StringBuffer _sb = StringBuffer();

  @override
  Map<String, dynamic>? bash(String word) {
    for (var i = 0; i < word.length; ++i) {
      for (var j = Alphabets.size - 1; j >= 0; --j) {
        if (Alphabets.lower_ordered[j] == word[i].toUpperCase()) {
          _sb.write(Alphabets.lower_ordered[Alphabets.size - (j + 1)]);
          break;
        }
      }
    }
    String? t = _sb.toString();
    _sb.clear();
    return JSON(200, STATUS.OK, "text ciphered")
        .addOptional(t.toString())
        .build();
  }

  @override
  Map<String, dynamic>? caesar(Shift dir, int shift, String word) {
    List<List<int>> resolved = Alphabets.stringToOrder(word);
    List<int> order = resolved[0];
    List<int> pos = resolved[1];
    dir == Shift.left ? shift *= -1 : shift;
    for (int i = 0; i < order.length; ++i) {
      int sum = (pos[i] - shift) % 26;
      if (order[i] == 32) {
        _sb.write(" ");
        continue;
      } else if (order[i] == 1) {
        _sb.write(Alphabets.upper_ordered[sum]);
        continue;
      } else if (order[i] == 2) {
        _sb.write(Alphabets.lower_ordered[sum]);
        continue;
      } else {
        _sb.write(String.fromCharCode(pos[i]));
        continue;
      }
    }
    String? t = _sb.toString();
    _sb.clear();
    return JSON(200, STATUS.OK, "text ciphered")
        .addOptional(t.toString())
        .build();
  }

  @override
  Map<String, dynamic>? vigenere(String word, String key) {
    List<List<int>> resolved = Alphabets.stringToOrder(word);
    List<int> order = resolved[0];
    List<int> pos = resolved[1];
    LinkedList<int> keyList = super._key(key);
    Node<int>? ptr = keyList.head;
    List<int> parsed = List<int>.filled(word.length, 0);
    for (int i = 0; i < word.length; ++i) {
      // repeat key till word length
      if (order[i] == 32 || order[i] == 0) continue;
      parsed[i] = ptr!.value;
      ptr = ptr.next as Node<int>?;
    }

    for (int i = 0; i < order.length; ++i) {
      int sum = pos[i] - parsed[i] % 26;
      if (order[i] == 32) {
        _sb.write(" ");
        continue;
      } else if (order[i] == 1) {
        _sumCheck(sum, Alphabets.upper_ordered);
        continue;
      } else if (order[i] == 2) {
        _sumCheck(sum, Alphabets.lower_ordered);
        continue;
      } else {
        _sb.write(String.fromCharCode(pos[i]));
        continue;
      }
    }

    String? ciphered = _sb.toString();
    _sb.clear();
    return JSON(200, STATUS.OK, "text ciphered")
        .addOptional(ciphered.toString())
        .build();
  }

  void _sumCheck(int sum, List<String> arr) {
    if (sum < 0) {
      sum += 26;
      _sb.write(arr[sum]);
      return;
    } else if (sum >= 26) {
      sum -= 26;
      _sb.write(arr[sum]);
      return;
    } else {
      _sb.write(arr[sum]);
      return;
    }
  }
}
