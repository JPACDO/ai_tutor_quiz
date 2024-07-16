class NoFoundException implements Exception {
  String element;

  NoFoundException({this.element = ""});

  @override
  String toString() {
    return '$element No found';
  }
}

class IdNoNullException implements Exception {
  @override
  String toString() {
    return 'Id no null';
  }
}

class NoIntegerException implements Exception {
  @override
  String toString() {
    return 'Id no integer';
  }
}

class NoSaveException implements Exception {
  @override
  String toString() {
    return 'Error to save';
  }
}
