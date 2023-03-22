import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:send_zap/module/contato/models/contato.dart';
import 'package:send_zap/module/contato/services/contato_store.dart';
import 'package:send_zap/module/home/components/whatsapp_clone_ui.dart';
import 'package:send_zap/module/home/store/whatsapp_store.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ContatoStore contatoStore = Modular.get();
  final WhatsappStore whatsappStore = Modular.get();

  final textTEC = TextEditingController();
  final textFN = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      textFN.requestFocus();
    });
    if (textTEC.text.isEmpty) {
      textTEC.text = "Texto de visualizacao";
    }
    // contatoStore.findByClassificacao(classificacao: "TODOS");
    super.initState();
  }

  final categoriaContatos = [
    "TODOS",
    "PDV",
    "COMERCIAL",
    "ÑANDUTI",
  ];
  int categoriaSelected = 0;

  List<Widget> getClassificacaoContatoButton() {
    List<Widget> list = [];
    for (var i = 0; i < categoriaContatos.length; i++) {
      list.add(
        Container(
          margin: EdgeInsets.only(right: 8),
          child: ToggleButton(
            checked: categoriaSelected == i,
            onChanged: (bool value) {
              setState(() {
                categoriaSelected = i;
                contatoStore.findByClassificacao(
                    classificacao: categoriaContatos[categoriaSelected]);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(categoriaContatos[i]),
            ),
          ),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = FluentTheme.of(context).typography.bodyLarge!.copyWith();
    final bodyStyle = FluentTheme.of(context).typography.body!.copyWith();
    return ScaffoldPage.scrollable(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CONTAINER IZQUERDO
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CAMPO TEXTO A ENVIAR
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Texto a enviar",
                          style: FluentTheme.of(context)
                              .typography
                              .bodyLarge!
                              .copyWith(color: Colors.white),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: SizedBox(
                                height: 96,
                                child: TextBox(
                                  controller: textTEC,
                                  focusNode: textFN,
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                            Button(
                                child: Text("Enviar"),
                                onPressed: () {
                                  whatsappStore.sendText(
                                      text: textTEC.text,
                                      contatos: contatoStore.dataProvider
                                          .where((element) => element.selected!)
                                          .toList());
                                })
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    // CAMPO CONTATOS
                    Column(
                      children: [
                        // TITULO E BOTAO LIMPAR
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Contactos",
                              style: FluentTheme.of(context)
                                  .typography
                                  .bodyLarge!
                                  .copyWith(color: Colors.white),
                            ),
                            Button(
                              style: ButtonStyle(
                                backgroundColor:
                                    ButtonState.all(Colors.transparent),
                              ),
                              child: Text("Limpiar filtros"),
                              onPressed: () {
                                debugPrint("limpa");
                                setState(() {
                                  categoriaSelected = 0;
                                });
                              },
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                    // CATEGORIA CONTATOS
                    SizedBox(
                      height: 36,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: getClassificacaoContatoButton(),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    // C
                    // TABLE CONTATOS
                    Column(
                      children: [
                        // COLUMN LABEL
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Nombre",
                                style: titleStyle,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Clasificación",
                                style: titleStyle,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Número",
                                style: titleStyle,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 480,
                          child: Observer(
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
                                      shrinkWrap: true,
                                      itemCount:
                                          contatoStore.dataProvider.length,
                                      itemBuilder: (context, index) {
                                        debugPrint(contatoStore
                                            .dataProvider.length
                                            .toString());
                                        Contato c =
                                            contatoStore.dataProvider[index];
                                        return Container(
                                          color: index % 2 == 0
                                              ? Colors.white.withOpacity(.05)
                                              : Colors.black.withOpacity(.05),
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Observer(
                                                builder: (_) {
                                                  return Checkbox(
                                                      checked: c.selected,
                                                      onChanged: (v) =>
                                                          c.selected = v);
                                                },
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  c.nome!.toUpperCase(),
                                                  style: bodyStyle,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  c.classificacao!
                                                      .toUpperCase(),
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
                                                  c.endereco!.toUpperCase(),
                                                  textAlign: TextAlign.center,
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
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 64,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Previsualización"),
                    SizedBox(
                      width: 16,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .7,
                      child: WhatsappCloneUi(textVisualizacao: textTEC),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
