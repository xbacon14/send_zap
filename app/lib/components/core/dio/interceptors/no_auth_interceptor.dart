import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NoAuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    const storage = FlutterSecureStorage();
    String? apiToken;
    String? sessionKey;
    try {
      apiToken = await storage.read(key: 'apiToken');
      sessionKey = await storage.read(key: 'sessionKey');
    } on PlatformException {
      await storage.deleteAll();
    }

    options.headers['apitoken'] = apiToken;
    options.headers['sessionkey'] = sessionKey;

    // options.headers['Access-Control-Allow-Origin:'] = '*';
    options.headers['Access-Control-Allow-Credentials'] = true;
    options.headers['Access-Control-Allow-Headers'] =
        'Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key?,X-Amz-Security-Token';
    options.headers['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS';

    handler.next(options);
  }
}
