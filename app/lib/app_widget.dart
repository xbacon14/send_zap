import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:send_zap/components/core/globals/globals.dart';
import 'package:send_zap/components/ui/ui_config.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    Modular.setNavigatorKey(navigatorKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FluentApp.router(
      key: UniqueKey(),
      themeMode: ThemeMode.dark,
      theme: UiConfig.themeData,
      debugShowCheckedModeBanner: false,
      locale: const Locale('es', 'PY'),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      color: UiConfig.themeData.accentColor,
    );
  }
}
