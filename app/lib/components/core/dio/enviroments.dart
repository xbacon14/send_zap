import 'package:flutter_dotenv/flutter_dotenv.dart' as dotEnv;

class Enviroments {
  Enviroments._();

  static Future<void> loadEnvs() async => dotEnv.dotenv.load(fileName: ".env");

  static String? param(String paramName) => dotEnv.dotenv.env[paramName];
}
