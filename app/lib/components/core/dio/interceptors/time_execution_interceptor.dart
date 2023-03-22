import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TimeExecutionInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final timer = DateTime.now();
    options.extra['start_time'] = timer.toIso8601String();
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final start = DateTime.parse(response.requestOptions.extra['start_time']);
    final totalExecution = DateTime.now().difference(start);

    debugPrint(
        "Tempo de execução ${totalExecution.inMilliseconds} milisegundos.");
    response.extra['execution_time'] = "${totalExecution.inMilliseconds}";
    handler.next(response);
  }
}
