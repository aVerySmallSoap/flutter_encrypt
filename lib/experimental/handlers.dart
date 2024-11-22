import 'dart:io';

import 'interfaces/Ilogging.dart';

class FileHandler implements IHandler {
  final String _name;
  final File _file;
  final IFormatter _formatter;

  FileHandler(this._name, this._file, this._formatter);

  @override
  void write(String s) {
    // TODO: implement write
  }

  @override
  IFormatter? getFormatter() {
    // TODO: implement getFormatter
    throw UnimplementedError();
  }
}

class ConsoleHandler implements IHandler {
  @override
  void write(String s) {
    // TODO: implement write
  }

  @override
  IFormatter? getFormatter() {
    // TODO: implement getFormatter
    throw UnimplementedError();
  }
}
