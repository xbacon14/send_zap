import 'package:dio/dio.dart';
import 'package:send_zap/components/core/dio/rest_client_exception.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.message!.contains("SocketException")) {
      // handler.reject(err)
      throw RestClientException(
          statusMessage: 'Sin conexion al servidor',
          statusCode: 0,
          error: err.error);
    }
    super.onError(err, handler);
  }
}
