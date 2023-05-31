import 'package:flutter_modular/flutter_modular.dart';
import 'package:send_zap/components/core/core_module.dart';
import 'package:send_zap/module/auth/repositories/auth_repository.dart';
import 'package:send_zap/module/auth/store/auth_store.dart';
import 'package:send_zap/module/contato/services/contato_store.dart';
import 'package:send_zap/module/home/home_module.dart';
import 'package:send_zap/module/home/repositories/whatsapp_repository.dart';
import 'package:send_zap/module/home/store/whatsapp_store.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => WhatsappRepository()),
        Bind.lazySingleton((i) => WhatsappStore(whatsappRepository: i.get())),
        Bind.lazySingleton((i) => AuthRepository()),
        Bind.lazySingleton((i) => AuthStore(authRepository: i.get())),
        Bind.lazySingleton((i) => ContatoStore()),
      ];

  @override
  List<Module> get imports =>
      super.imports +
      [
        CoreModule(),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute("/", module: HomeModule()),
      ];
}
