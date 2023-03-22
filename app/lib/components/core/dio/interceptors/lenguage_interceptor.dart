import 'package:dio/dio.dart';

class LenguageInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // String lenguage;
    // final storage = new FlutterSecureStorage();
    // lenguage = await storage.read(key: 'lenguage');
    // options.headers['Accept-Language'] = lenguage ?? Theme.of(context).locale.languageCode;
    handler.next(options);
  }
}
