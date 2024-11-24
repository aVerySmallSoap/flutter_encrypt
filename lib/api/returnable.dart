interface class Returnable {
  Map<String, dynamic>? build() {
    return null;
  }
}

// Common responses are 200, 400, 404, 500
// OK, BAD REQUEST, NOT FOUND, INTERNAL SERVER ERROR

enum STATUS { OK, badRequest, notFound, internalError }

class JSON implements Returnable {
  final int _code;
  final STATUS _status;
  final String _message;
  Map<String, dynamic>? _returnable;
  String? _type;
  Map<String, String>? _error;
  Object? _optional;

  JSON(this._code, this._status, this._message,
      [this._type, this._error, this._optional]);

  JSON addType(String s) {
    _type = s;
    return this;
  }

  JSON addError(String e, String m) {
    _error = {"error": e, "message": m};
    return this;
  }

  JSON addOptional(Object o) {
    _optional = o;
    return this;
  }

  @override
  Map<String, dynamic>? build() {
    _returnable = {"code": _code, "status": _status, "message": _message};
    if (_type != null) {
      _returnable?.addAll({"type": _type});
    }
    if (_error != null) {
      _returnable?.addAll(_error!);
    }
    if (_optional != null) {
      _returnable?.addAll({"additional": _optional});
    }
    return _returnable;
  }
}
