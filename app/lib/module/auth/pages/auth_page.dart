import 'dart:convert';
import 'dart:typed_data';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:send_zap/components/core/socket/socket_store.dart';
import 'package:send_zap/components/ui/form_text_box.dart';
import 'package:send_zap/module/auth/store/auth_store.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final SocketStore socketStore = Modular.get();
  final AuthStore authStore = Modular.get();
  final nomeTEC = TextEditingController();
  final nomeFN = FocusNode();

  @override
  void initState() {
    socketStore.connectAndListen();
    authStore.checkLogin().then((value) {
      if (value) {
        Modular.to.popAndPushNamed(
          '/home',
        );
        socketStore.dispose();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FocusScope.of(context).requestFocus(nomeFN);
    });
    super.initState();
  }

  @override
  void dispose() {
    socketStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      scrollController: ScrollController(),
      children: [
        Text(
          "Inicie sesión",
          style: FluentTheme.of(context).typography.titleLarge,
        ),
        SizedBox(
          height: 24,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // NOME DA SESSÃO
            SizedBox(
              width: 440,
              child: Row(
                children: [
                  Flexible(
                    child: FormTextBox(
                      label: 'Nombre de la sesión: ',
                      controller: nomeTEC,
                      focusNode: nomeFN,
                      onSubmit: () {},
                      validator: () {
                        if (nomeTEC.text.isNotEmpty) {
                          return true;
                        } else {
                          return false;
                        }
                      },
                    ),
                  ),
                  Button(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Enviar",
                        style: FluentTheme.of(context)
                            .typography
                            .bodyLarge!
                            .copyWith(
                              fontSize: 16,
                            ),
                      ),
                    ),
                    onPressed: () {
                      if (nomeTEC.text.isNotEmpty) {
                        authStore.currentRecord.session = nomeTEC.text;
                        authStore.currentRecord.sessionKey =
                            "${nomeTEC.text}@session";
                        authStore.startSession();
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 48,
            ),
            Text(
              "Vincule su whatsapp con este QR",
              style: FluentTheme.of(context).typography.bodyLarge,
            ),
            SizedBox(
              height: 16,
            ),
            StreamBuilder<String>(
              stream: socketStore.getQrCode,
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  List<String> strings = snapshot.data!.split(";");
                  Uint8List _bytes =
                      Base64Decoder().convert(strings[1].substring(7));
                  return Container(
                    child: Image.memory(_bytes),
                  );
                } else {
                  return Text("sin qr");
                }
              },
            )
          ],
        )
      ],
    );
  }
}
