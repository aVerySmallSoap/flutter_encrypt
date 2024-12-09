//Enum?????

class Alphabets {
  static const int size = 26;
  static final List<String> upper_ordered = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];
  static final List<String> lower_ordered = <String>[
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z'
  ];
  static final List<int> numerical = <int>[
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25
  ];

  // Methods here could be written as Asynchronous
  //TODO: Make Alphabets util methods async
  //TODO: Write documentation

  static List<int> toNumerics(String s) {
    List<int> l = List<int>.filled(s.length, 0);
    for (int i = 0; i < s.length; ++i) {
      if (s[i] == ' ') {
        l[i] = 32;
        continue;
      }
      for (int j = 0; j < 26; ++j) {
        if (lower_ordered[j] == s[i].toUpperCase()) {
          l[i] = numerical[j];
          break;
        }
      }
    }
    return l;
  }

  static List<List<int>> stringToOrder(String s) {
    List<int> order = List.filled(
        s.length, 0); // 2 - lower; - 1 upper; 0 - special; 32 - space
    List<int> arr = List.filled(s.length, 0);
    for (int i = 0; i < s.length; ++i) {
      if (s.codeUnits[i] == 32) {
        order[i] = 32;
        arr[i] = 32;
        continue;
      }
      for (int j = 0; j < 27; ++j) {
        if (j == 26) {
          arr[i] = s.codeUnits[i];
          break;
        }
        if (s[i] == upper_ordered[j]) {
          order[i] = 1;
          arr[i] = numerical[j];
          break;
        } else if (s[i] == lower_ordered[j]) {
          order[i] = 2;
          arr[i] = numerical[j];
          break;
        }
      }
    }
    return [order, arr];
  }
}
