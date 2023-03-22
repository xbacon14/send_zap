class RestClientException implements Exception {
  final String statusMessage;
  final int statusCode;
  final dynamic error;

  RestClientException({
    required this.statusMessage,
    required this.statusCode,
    this.error,
  });
}
