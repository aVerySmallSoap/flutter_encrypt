//Enum?????
class Alphabets {
  static const int size = 26;
  static final List<String> ordered = <String>[
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
      for (int j = 0; j < ordered.length; ++j) {
        if (ordered[j] == s[i].toUpperCase()) {
          l[i] = numerical[j];
          break;
        }
      }
    }
    return l;
  }
}
