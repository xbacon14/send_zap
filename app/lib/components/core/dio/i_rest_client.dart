import 'package:send_zap/components/core/dio/rest_client_response.dart';

abstract class IRestClient {
  Future<RestClientResponse<T>> post<T>(String path,
      {dynamic data,
      Map<String, dynamic> queryParameters,
      Map<String, dynamic> headers});

  Future<RestClientResponse<T>> get<T>(String path,
      {Map<String, dynamic> queryParameters, Map<String, dynamic> headers});

  Future<RestClientResponse<T>> put<T>(String path,
      {dynamic data,
      Map<String, dynamic> queryParameters,
      Map<String, dynamic> headers});

  Future<RestClientResponse<T>> delete<T>(String path,
      {Map<String, dynamic> queryParameters, Map<String, dynamic> headers});

  Future<RestClientResponse<T>> patch<T>(String path,
      {dynamic data,
      Map<String, dynamic> queryParameters,
      Map<String, dynamic> headers});

  Future<RestClientResponse<T>> request<T>(String path,
      {Map<String, dynamic> queryParameters, Map<String, dynamic> headers});
}
