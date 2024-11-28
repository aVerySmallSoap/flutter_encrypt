// ignore_for_file: unused_field

import 'interfaces/i_logging.dart';

enum SEVERITY { info, warning, error, severe, debug }

class Logger {
  final String _name;
  final SEVERITY level;
  Map<String, IHandler>? handlers;

  Logger(this._name, this.level);

  void init() {}

  void log(String message, SEVERITY s) {}
}

class LogEntry {
  final String? message;
  final SEVERITY level;
  final String timestamp = DateTime.now().toString();

  LogEntry(this.message, this.level);
}
