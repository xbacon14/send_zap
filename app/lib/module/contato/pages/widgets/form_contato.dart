import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:send_zap/components/ui/form_text_box.dart';
import 'package:send_zap/module/contato/models/contato.dart';
import 'package:send_zap/module/contato/services/contato_store.dart';

class FormContato extends StatefulWidget {
  const FormContato({Key? key}) : super(key: key);

  @override
  State<FormContato> createState() => _FormContatoState();
}

class _FormContatoState extends State<FormContato> {
  final ContatoStore contatoStore = Modular.get();

  final clasificaciones = [
    "COMERCIAL",
    "ÑANDUTI",
    "PDV",
  ];
  String selected = "COMERCIAL";

  final _formKey = GlobalKey<FormState>();

  final nomeTEC = TextEditingController();
  final nomeFN = FocusNode();

  final telefoneTEC = TextEditingController();
  final telefoneFN = FocusNode();

  final enderecoTEC = TextEditingController();
  final enderecoFN = FocusNode();

  final classificacaoFN = FocusNode();

  limpiar(BuildContext ctx) {
    nomeTEC.clear();
    telefoneTEC.clear();
    enderecoTEC.clear();
    selected = clasificaciones[0];
    FocusScope.of(context).requestFocus(nomeFN);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FocusScope.of(context).requestFocus(nomeFN);
    });

    if (!kReleaseMode) {
      nomeTEC.text = "ITALO GOLIN";
      telefoneTEC.text = "595981383068";
      enderecoTEC.text = "CALLE SAN MIGUEL 912";
      selected = "PDV";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: Container(
        width: 260,
        height: 64,
        padding: EdgeInsets.all(12),
        child: Button(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Row(children: [
            Icon(
              FluentIcons.back,
              size: 24,
              color: Colors.white,
            ),
            const SizedBox(
              width: 16,
            ),
            Row(
              children: [
                Text(
                  "Nuevo contacto",
                  style: FluentTheme.of(context)
                      .typography
                      .bodyLarge!
                      .copyWith(color: Colors.white, fontSize: 24),
                ),
              ],
            ),
          ]),
        ),
      ),
      content: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 24,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                // nome
                FormTextBox(
                  label: 'nome:',
                  controller: nomeTEC,
                  focusNode: nomeFN,
                  onSubmit: () =>
                      FocusScope.of(context).requestFocus(telefoneFN),
                  validator: () {
                    if (nomeTEC.text.isNotEmpty) {
                      return true;
                    } else {
                      return false;
                    }
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                // TELEFONE
                FormTextBox(
                  label: 'telefone:',
                  controller: telefoneTEC,
                  focusNode: telefoneFN,
                  onSubmit: () =>
                      FocusScope.of(context).requestFocus(enderecoFN),
                  validator: () {
                    if (telefoneTEC.text.isNotEmpty) {
                      return true;
                    } else {
                      return false;
                    }
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                // nome
                FormTextBox(
                  label: 'Dirección:',
                  controller: enderecoTEC,
                  focusNode: enderecoFN,
                  onSubmit: () =>
                      FocusScope.of(context).requestFocus(classificacaoFN),
                  validator: () {
                    if (enderecoTEC.text.isNotEmpty) {
                      return true;
                    } else {
                      return false;
                    }
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                // nome
                Row(
                  children: [
                    Flexible(
                        child: SizedBox(
                            width: 120, child: Text("Clasificación:"))),
                    SizedBox(
                      width: 16,
                    ),
                    Flexible(
                      child: SizedBox(
                        width: 360,
                        child: ComboBox<String>(
                          value: selected,
                          focusNode: classificacaoFN,
                          items: clasificaciones
                              .map((e) => ComboBoxItem<String>(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              if (value != null) {
                                selected = value;
                              }
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24,
          ),
          SizedBox(
            width: 494,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Button(
                  style: ButtonStyle(
                      backgroundColor: ButtonState.all(Colors.transparent)),
                  onPressed: () {
                    // TODO LIMPIAR
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Limpiar",
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Button(
                  onPressed: () {
                    final contato = Contato()
                      ..nome = nomeTEC.text
                      ..telefone = telefoneTEC.text
                      ..endereco = enderecoTEC.text
                      ..classificacao = selected;
                    if (contato.isValid()) {
                      // contatoStore
                      //     .saveContato(contato: contato)
                      //     .then((value) => Navigator.pop(context));
                    } else {
                      debugPrint("not valid");
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Guardar",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
