import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:send_zap/module/contato/models/contato.dart';

part 'db_service.g.dart';

@DriftDatabase(include: {"tables.drift"})
class DbService extends _$DbService {
  DbService() : super(openConnection());

  @override
  int get schemaVersion => 1;

  // Future<List<Contato>> findContatoByCondition({required String condition}) =>
  //     customSelect("SELECT * FROM BsContato WHERE nome LIKE ?;",
  //             variables: [Variable.withString(condition)],
  //             readsFrom: {bsContato})
  //         .get()
  //         .then((value) => value.map((e) => Contato.fromMap(e.data)).toList());
}

LazyDatabase openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'contato.sqlite'));
    return NativeDatabase.createInBackground(file, logStatements: true);
  });
}
