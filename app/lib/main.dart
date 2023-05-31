import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:send_zap/app_module.dart';
import 'package:send_zap/app_widget.dart';
import 'package:send_zap/components/core/dio/application_starter_config.dart';

// final dbService = DbService();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApplicationStarterConfig().configureApp();
  runApp(
    ModularApp(
      module: AppModule(),
      child: AppWidget(),
    ),
  );
}
