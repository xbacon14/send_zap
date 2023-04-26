import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:send_zap/module/contato/models/contato.dart';
import 'package:send_zap/module/contato/pages/widgets/form_contato.dart';
import 'package:send_zap/module/contato/services/contato_store.dart';

class ContatoPage extends StatefulWidget {
  const ContatoPage({Key? key}) : super(key: key);

  @override
  State<ContatoPage> createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {
  final ContatoStore contatoStore = Modular.get();

  final searchTEC = TextEditingController();

  @override
  void initState() {
    contatoStore.findContatosByCondition(condition: "");
    // contatoStore.findAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = FluentTheme.of(context).typography.bodyLarge!.copyWith();
    final bodyStyle = FluentTheme.of(context).typography.body!.copyWith();
    return ScaffoldPage.withPadding(
      header: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Row(
          children: [
            Text(
              "Contactos",
              style: FluentTheme.of(context)
                  .typography
                  .bodyLarge!
                  .copyWith(fontSize: 24),
            ),
            const SizedBox(
              width: 48,
            ),
            SizedBox(
              width: 288,
              child: TextBox(
                placeholder: "Consulte por nombre o numero de telefono",
                decoration: BoxDecoration(),
                onSubmitted: (value) {
                  contatoStore.findContatosByCondition(condition: value);
                },
                suffix: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    FluentIcons.search,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            Button(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Importar contatos",
                  style: FluentTheme.of(context).typography.bodyLarge!.copyWith(
                        fontSize: 16,
                      ),
                ),
              ),
              onPressed: () {
                contatoStore.importacaoXLSX();
                // contatoStore.deleteAll();
              },
            ),
            Button(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Delete all",
                  style: FluentTheme.of(context).typography.bodyLarge!.copyWith(
                        fontSize: 16,
                      ),
                ),
              ),
              onPressed: () {
                contatoStore.deleteAll();
              },
            ),
            Button(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Nuevo contacto",
                  style: FluentTheme.of(context).typography.bodyLarge!.copyWith(
                        fontSize: 16,
                      ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    FluentPageRoute(
                      builder: (context) => FormContato(),
                    ));
              },
            ),
          ],
        ),
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 1024),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Nombre",
                      textAlign: TextAlign.center,
                      style: titleStyle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Clasificación",
                      textAlign: TextAlign.center,
                      style: titleStyle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Número",
                      textAlign: TextAlign.center,
                      style: titleStyle,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Dirección",
                      textAlign: TextAlign.center,
                      style: titleStyle,
                    ),
                  ),
                  SizedBox(
                    width: 48,
                  ),
                ],
              ),
              Observer(
                builder: (context) {
                  return contatoStore.dataProvider.isEmpty
                      ? SizedBox(
                          height: 240,
                          child: Center(
                            child: Text(
                              "Lista vacia",
                              style: FluentTheme.of(context)
                                  .typography
                                  .bodyLarge!
                                  .copyWith(fontSize: 24),
                            ),
                          ),
                        )
                      : ListView.builder(
                          key: UniqueKey(),
                          shrinkWrap: true,
                          itemCount: contatoStore.dataProvider.length,
                          itemBuilder: (context, index) {
                            Contato c = contatoStore.dataProvider[index];
                            return Container(
                              color: index % 2 == 0
                                  ? Colors.white.withOpacity(.05)
                                  : Colors.black.withOpacity(.05),
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      c.nome!.toUpperCase(),
                                      style: bodyStyle,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      c.classificacao!.toUpperCase(),
                                      style: bodyStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      c.telefone!.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: bodyStyle,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      c.endereco?.toUpperCase() ?? "S/D",
                                      textAlign: TextAlign.left,
                                      style: bodyStyle,
                                    ),
                                  ),
                                  Button(
                                      child: Text("Editar"),
                                      onPressed: () {
                                        // TODO EDITAR CONTACTO
                                        debugPrint("Editar");
                                      }),
                                ],
                              ),
                            );
                          },
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
