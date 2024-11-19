import 'dart:collection';

enum SEVERITY { info, warning, error, severe, debug }

class Logger {
  Queue<String> buffer = Queue();
  final StringBuffer _sb = StringBuffer();

  void init() {}

  void log(String message, [SEVERITY s = SEVERITY.info]) {}

  void toJSON() {}
}
