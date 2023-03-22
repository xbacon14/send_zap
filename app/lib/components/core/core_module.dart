import 'package:flutter_modular/flutter_modular.dart';
import 'package:send_zap/components/core/dio/api_rest_client.dart';
import 'package:send_zap/components/core/socket/socket_store.dart';
import 'package:send_zap/database/db_service.dart';

class CoreModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
      (i) => Api.withOutAuth(),
      export: true,
    ),
    Bind.lazySingleton(
      (i) => Api,
      export: true,
    ),
    Bind.lazySingleton(
      (i) => SocketStore(),
      export: true,
    ),
    // Bind.singleton(
    //   (i) => DataShared(),
    //   export: true,
    // )
    Bind.singleton(
      (i) => DbService(),
      export: true,
    )
  ];
}
