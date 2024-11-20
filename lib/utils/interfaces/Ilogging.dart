import 'dart:io';

interface class IHandler {
  void write(String s) {}

  IFormatter? getFormatter() {
    return null;
  }
}

interface class IFormatter {
  void format([String? s, File? f]) {}
}

interface class ILogFactory {
  ILogFactory? build() {
    return null;
  }
}
