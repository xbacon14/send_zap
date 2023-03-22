import 'package:dio/dio.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:send_zap/components/core/dio/api_rest_client.dart';
import 'package:send_zap/components/core/dio/rest_client_response.dart';
import 'package:send_zap/module/auth/models/auth.dart';

class AuthRepository {
  final Api api;

  AuthRepository() : api = Api.withOutAuth();

  Future<RestClientResponse> startSession({required Auth auth}) async {
    return await api.post('/start', data: auth.toMap());
  }

  Future<RestClientResponse?> getQRCode({
    required String session,
    required String sessionKey,
  }) async {
    RestClientResponse? response;
    try {
      response = await Api().get('/getQrCode', queryParameters: {
        "session": "",
        "sessionKey": "",
      });
    } on DioError catch (e) {
      response = null;
      if (e.response!.statusCode == 400) {
        AlertController.show(
            "Aviso",
            "Ya existe una sesión vinculada con este nombre",
            TypeAlert.warning);
      }
    } catch (e) {}
    return response;
  }
}
