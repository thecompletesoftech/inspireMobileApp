class Failure {
  final dynamic error;
  final String errorMessage;
  final bool requireConfirmation;

  Failure(
      {this.error,
      required this.errorMessage,
      this.requireConfirmation = false});

  @override
  String toString() {
    return errorMessage;
  }
}
