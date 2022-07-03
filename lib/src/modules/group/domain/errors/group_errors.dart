class GroupException implements Exception {
  final String message;

  GroupException({
    required this.message,
  });

  @override
  String toString() {
    return "GroupException: $message";
  }
}
