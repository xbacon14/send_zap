import 'dart:io';

import 'package:dio/dio.dart';
import 'package:send_zap/components/core/dio/interceptors/connectivity_interceptor.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final ConnectivityInterceptor requestRetrier;

  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
  });

  @override
  onError(DioError err, ErrorInterceptorHandler handler) {
    if (_shouldRetry(err)) {
      try {
        // TESTAR NO MOBILE
        // TESTAR NO MOBILE
        // TESTAR NO MOBILE
        // TESTAR NO MOBILE
        // TESTAR NO MOBILE
        requestRetrier.scheduleRequestRetry(err.requestOptions);
      } catch (e) {
        DioError error = DioError(error: e, requestOptions: err.requestOptions);
        handler.next(error);
      }
    }
    return handler.next(err);
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.unknown &&
        err.error != null &&
        err.error is SocketException;
  }
}
