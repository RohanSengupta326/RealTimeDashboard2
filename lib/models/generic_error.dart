class GenericError implements Exception {
  final String message;
  GenericError(this.message);

  @override
  String toString() {
    return message;
  }
}
