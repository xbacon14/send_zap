import 'package:flutter_modular/flutter_modular.dart';
import 'package:send_zap/module/auth/pages/auth_page.dart';
import 'package:send_zap/module/contato/pages/contato_page.dart';
import 'package:send_zap/module/home/pages/home_page.dart';
import 'package:send_zap/module/home/pages/home_view.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          "/",
          child: (context, args) => AuthPage(),
        ),
        ChildRoute(
          "/home",
          child: (context, args) => HomePage(),
          children: [
            ChildRoute(
              '/homeView',
              child: (context, args) => HomeView(),
            ),
            ChildRoute(
              '/contatos',
              child: (context, args) => ContatoPage(),
            ),
          ],
        ),
        // ChildRoute(
        //   Modular.initialRoute,
        //   child: (context, args) => HomePage(),
        // ),
      ];
}
