import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobx/mobx.dart';
import 'package:send_zap/module/contato/models/contato.dart';
import 'package:send_zap/module/home/models/send_text.dart';
import 'package:send_zap/module/home/repositories/whatsapp_repository.dart';
part 'whatsapp_store.g.dart';

class WhatsappStore = WhatsappStoreBase with _$WhatsappStore;

abstract class WhatsappStoreBase with Store {
  WhatsappStoreBase({required this.whatsappRepository});
  final WhatsappRepository whatsappRepository;

  @observable
  bool selectAll = false;

  Future<void> sendText(
      {required String text, required List<Contato> contatos}) async {
    final storage = FlutterSecureStorage();
    if (contatos.isNotEmpty) {
      // String? sessionName = await storage.read(key: 'sessionName');
      // String? sessionKey = await storage.read(key: 'sessionkey');
      String sessionName = 'FLEX_PDV_VENDAS';
      String sessionKey = '9QyQJ-y3hUDZ5hP6!4VX?U9qfHMGr%a^mGC-WDQS2-xr\$xQ7';
      final Random random = Random();
      int duration = 5;
      for (var i = 0; i < contatos.length; i++) {
        whatsappRepository.sendText(
          textDto: SendText()
            ..session = sessionName
            ..url = sessionKey
            ..number = contatos[i].telefone
            ..text = text,
        );
        debugPrint(
            "${i + 1}/${contatos.length} - ${contatos[i].nome}, duración: $duration");
        await Future.delayed(Duration(seconds: duration));
        duration = random.nextInt(11) + 5;
      }
    }
  }
}
