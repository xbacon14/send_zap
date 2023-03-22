import 'package:send_zap/components/core/dio/api_rest_client.dart';
import 'package:send_zap/components/core/dio/rest_client_response.dart';
import 'package:send_zap/module/home/models/send_text.dart';

class WhatsappRepository {
  final Api api;

  WhatsappRepository() : api = Api();

  Future<RestClientResponse> sendText({required SendText textDto}) async {
    return await api.post("/sendText", data: textDto.toMap());
  }
}
