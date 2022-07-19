class InternetError implements Exception {
  final String message;
  InternetError(this.message);

  @override
  String toString() {
    return message;
  }
}
