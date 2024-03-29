import 'package:drift/drift.dart';
import 'package:mobx/mobx.dart';
import 'package:send_zap/database/db_service.dart';
import 'package:send_zap/module/contato/models/contato.dart';
import 'package:send_zap/module/contato/services/contato_service.dart';

part 'contato_store.g.dart';

class ContatoStore = ContatoStoreBase with _$ContatoStore;

abstract class ContatoStoreBase with Store {
  ContatoStoreBase(this.dbService);
  final DbService dbService;

  static String boxName = "contatos";
  String lastCondition = "";

  @observable
  ObservableList<Contato> dataProvider = ObservableList.of([]);

  Future<void> importacaoXLSX() async {
    List<Contato> lista = await ContatoService.convertFileResultToContato();
    saveListaContato(contatos: lista)
        .then((value) => findContatosByCondition(condition: ""));
    // for (var l in lista) {
    //   saveContato(contato: l);
    // }
  }

  Future<void> findByClassificacao({required String classificacao}) async {
    Future<List<BsContatoData>> result;
    // RETORNA TODOS
    if (classificacao.compareTo('TODOS') == 0) {
      result = (dbService.select(dbService.bsContato)).get();
    } else {
      // RETORNA PELA CONDICAO DE NOME
      result = (await dbService.select(dbService.bsContato)
            ..where((tbl) {
              return tbl.classificacao.like('$classificacao');
            }))
          .get();
    }

    dataProvider.clear();
    dataProvider.addAll(await result
        .then((value) => value.map((e) => Contato.fromMap(e.toJson()))));
  }

  Future<void> saveContato({required Contato contato}) async {
    await dbService
        .into(dbService.bsContato)
        .insert(
          BsContatoCompanion.insert(
            nome: Value(contato.nome),
            telefone: Value(contato.telefone),
            endereco: Value(contato.endereco),
            classificacao: Value(contato.classificacao),
          ),
        )
        .then((value) => findContatosByCondition(condition: ""));
  }

  Future<void> saveListaContato({required List<Contato> contatos}) async {
    for (var c in contatos) {
      await dbService
          .into(dbService.bsContato)
          .insert(BsContatoCompanion.insert(
            nome: Value(c.nome),
            telefone: Value(c.telefone),
            endereco: Value(c.endereco),
            classificacao: Value(c.classificacao),
          ));
    }
  }

  Future<void> findContatosByCondition({required String condition}) async {
    final result = dbService.select(dbService.bsContato)
      ..where((tbl) {
        return tbl.nome.like('%$condition%');
      })
      ..get();

    dataProvider.clear();
    dataProvider.addAll(await result
        .get()
        .then((value) => value.map((e) => Contato.fromMap(e.toJson()))));
  }

  Future<void> deleteAll() async {
    (dbService.delete(dbService.bsContato)
          ..where((t) => t.id.isSmallerThanValue(10000)))
        .go()
        .then((value) => findContatosByCondition(condition: ""));
  }

  void setAllSelect({required bool value}) {
    for (var c in dataProvider) {
      c.selected = value;
    }
  }
}
