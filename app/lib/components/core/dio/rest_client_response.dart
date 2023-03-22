class RestClientResponse<T> {
  T data;
  int statusCode;
  String statusMessage;
  Exception? exception;
  RestClientResponse({
    required this.data,
    required this.statusCode,
    required this.statusMessage,
    this.exception,
  });
}
