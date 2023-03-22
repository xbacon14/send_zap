import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:send_zap/components/core/dio/enviroments.dart';
import 'package:send_zap/components/core/dio/i_rest_client.dart';
import 'package:send_zap/components/core/dio/interceptors/auth_interceptor.dart';
import 'package:send_zap/components/core/dio/interceptors/connectivity_interceptor.dart';
import 'package:send_zap/components/core/dio/interceptors/error_interceptor.dart';
import 'package:send_zap/components/core/dio/interceptors/retry_on_connection_change_interceptor.dart';
import 'package:send_zap/components/core/dio/rest_client_exception.dart';
import 'package:send_zap/components/core/dio/rest_client_response.dart';

import 'interceptors/no_auth_interceptor.dart';

class Api implements IRestClient {
  late Dio _dio;

  final _baseOptions = BaseOptions(
    baseUrl: Enviroments.param('base_url') ?? '',
    connectTimeout: Duration(milliseconds: 120000),
    receiveTimeout: Duration(milliseconds: 120000),
  );

  Api() {
    _dio = Dio(_baseOptions);
    _dio.interceptors.addAll([
      ErrorInterceptor(),
      AuthInterceptor(),
      RetryOnConnectionChangeInterceptor(
        requestRetrier: ConnectivityInterceptor(
          dio: _dio,
          connectivity: Connectivity(),
        ),
      ),
    ]);
  }

  Api.withOutAuth() {
    _dio = Dio(_baseOptions);
    _dio.interceptors.addAll([
      ErrorInterceptor(),
      NoAuthInterceptor(),
      RetryOnConnectionChangeInterceptor(
        requestRetrier: ConnectivityInterceptor(
          dio: _dio,
          connectivity: Connectivity(),
        ),
      ),
    ]);
  }

  @override
  Future<RestClientResponse<T>> post<T>(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final responde = await _dio.post(path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers));
      return _sucessManager<T>(responde);
    } on DioError catch (e) {
      return _errorManager(e);
    }
  }

  @override
  Future<RestClientResponse<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final responde = await _dio.get(path,
          queryParameters: queryParameters, options: Options(headers: headers));
      return _sucessManager<T>(responde);
    } on DioError catch (e) {
      return _errorManager(e);
    }
  }

  @override
  Future<RestClientResponse<T>> put<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final responde = await _dio.put(path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers));
      return _sucessManager<T>(responde);
    } on DioError catch (e) {
      return _errorManager(e);
    }
  }

  @override
  Future<RestClientResponse<T>> delete<T>(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final responde = await _dio.delete(path,
          queryParameters: queryParameters, options: Options(headers: headers));
      return _sucessManager<T>(responde);
    } on DioError catch (e) {
      return _errorManager(e);
    }
  }

  @override
  Future<RestClientResponse<T>> patch<T>(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final responde = await _dio.patch(path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers));
      return _sucessManager<T>(responde);
    } on DioError catch (e) {
      return _errorManager(e);
    }
  }

  @override
  Future<RestClientResponse<T>> request<T>(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final responde = await _dio.request(path,
          queryParameters: queryParameters, options: Options(headers: headers));
      return _sucessManager<T>(responde);
    } on DioError catch (e) {
      return _errorManager(e);
    }
  }

  _errorManager(DioError e) async {
    if (e.error != null) {
      if (e.type == DioErrorType.unknown) {
        debugPrint("Connection failed");
        Modular.to.pushNamedAndRemoveUntil('/error_conexion', (p0) => false);
        throw RestClientException(
          statusMessage: e.response?.statusMessage ?? "erro",
          statusCode: e.response?.statusCode ?? 0,
        );
      }
      if (e.response!.statusCode == 500) {
        AlertController.show(
            "Error", 'No fue posible completar la operación', TypeAlert.error);

        RestClientException(
          statusMessage: e.response?.statusMessage ?? "erro",
          statusCode: e.response!.statusCode!,
        );
      }
      if (e.response!.statusCode == 401) {
        debugPrint('Error de Autenticación!');

        AlertDialog(
          title: Text('Error de autenticación!, usuario o seña incorrectos'),
          actions: [
            Button(
                child: Text("Autenticar"),
                onPressed: () {
                  if (Modular.to.path.toString().compareTo('/login') == 0) {
                    Modular.to.pop();
                  } else {
                    Modular.to.pushNamedAndRemoveUntil('/login', (p0) => false);
                  }
                })
          ],
        );

        RestClientException(
          statusMessage: e.response?.statusMessage ?? "erro",
          statusCode: e.response!.statusCode!,
        );
      }
    }

    if (e.error is String) {
      debugPrint("Connection failed");
      Modular.to.pushNamedAndRemoveUntil('/error_conexion', (p0) => false);
      RestClientException(
        statusMessage: e.response?.statusMessage ?? "erro",
        statusCode: e.response!.statusCode!,
      );
    } else {
      RestClientException(
        statusMessage: e.response?.statusMessage ?? "erro",
        statusCode: e.response?.statusCode ?? 0,
      );
    }
  }

  RestClientResponse<T> _sucessManager<T>(Response<dynamic> response) {
    return RestClientResponse(
        data: response.data,
        statusCode: response.statusCode!,
        statusMessage: response.statusMessage!);
  }
}
