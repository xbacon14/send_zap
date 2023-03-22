import 'package:flutter/foundation.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobx/mobx.dart';
import 'package:send_zap/module/auth/models/auth.dart';
import 'package:send_zap/module/auth/repositories/auth_repository.dart';
part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  AuthStoreBase({required this.authRepository});

  @observable
  bool processando = false;

  final AuthRepository authRepository;

  Auth currentRecord = Auth();

  Future<void> startSession() async {
    processando = true;
    await saveDataInSecure(currentRecord);
    final response = await authRepository
        .startSession(auth: currentRecord)
        .whenComplete(() => processando = false);

    if (response.statusCode == 200) {
      debugPrint("logou");
    }
  }

  Future<void> getQrCode({
    required String session,
    required String sessionKey,
  }) async {
    processando = true;

    final response = await authRepository.getQRCode(
        session: session, sessionKey: sessionKey);

    if (response!.statusCode == 200) {
      AlertController.show(
          "Exito", "Se ha retornado el codigo QR", TypeAlert.success);
    } else {
      AlertController.show("Error", response.statusMessage, TypeAlert.success);
    }
  }

  Future<bool> checkLogin() async {
    final storage = FlutterSecureStorage();
    String? sessionKey = await storage.read(key: "sessionKey");
    String? apiToken = await storage.read(key: "apiToken");
    String? sessionName = await storage.read(key: "sessionName");

    debugPrint("sessionKey $sessionKey");
    debugPrint("apiToken $apiToken");
    debugPrint("sessionName $sessionName");

    if (sessionName != null && apiToken != null && sessionKey != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> saveDataInSecure(Auth auth) async {
    final storage = FlutterSecureStorage();
    storage.write(key: 'sessionKey', value: auth.sessionKey);
    storage.write(key: 'sessionName', value: auth.session);
    storage.write(key: 'apiToken', value: "flextech");
  }
}
