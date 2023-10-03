// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_service.dart';

// ignore_for_file: type=lint
class BsContato extends Table with TableInfo<BsContato, BsContatoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  BsContato(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _telefoneMeta =
      const VerificationMeta('telefone');
  late final GeneratedColumn<String> telefone = GeneratedColumn<String>(
      'telefone', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _enderecoMeta =
      const VerificationMeta('endereco');
  late final GeneratedColumn<String> endereco = GeneratedColumn<String>(
      'endereco', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _classificacaoMeta =
      const VerificationMeta('classificacao');
  late final GeneratedColumn<String> classificacao = GeneratedColumn<String>(
      'classificacao', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns =>
      [id, nome, telefone, endereco, classificacao];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'BS_CONTATO';
  @override
  VerificationContext validateIntegrity(Insertable<BsContatoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    }
    if (data.containsKey('telefone')) {
      context.handle(_telefoneMeta,
          telefone.isAcceptableOrUnknown(data['telefone']!, _telefoneMeta));
    }
    if (data.containsKey('endereco')) {
      context.handle(_enderecoMeta,
          endereco.isAcceptableOrUnknown(data['endereco']!, _enderecoMeta));
    }
    if (data.containsKey('classificacao')) {
      context.handle(
          _classificacaoMeta,
          classificacao.isAcceptableOrUnknown(
              data['classificacao']!, _classificacaoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BsContatoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BsContatoData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome']),
      telefone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}telefone']),
      endereco: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}endereco']),
      classificacao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}classificacao']),
    );
  }

  @override
  BsContato createAlias(String alias) {
    return BsContato(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class BsContatoData extends DataClass implements Insertable<BsContatoData> {
  final int id;
  final String? nome;
  final String? telefone;
  final String? endereco;
  final String? classificacao;
  const BsContatoData(
      {required this.id,
      this.nome,
      this.telefone,
      this.endereco,
      this.classificacao});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || nome != null) {
      map['nome'] = Variable<String>(nome);
    }
    if (!nullToAbsent || telefone != null) {
      map['telefone'] = Variable<String>(telefone);
    }
    if (!nullToAbsent || endereco != null) {
      map['endereco'] = Variable<String>(endereco);
    }
    if (!nullToAbsent || classificacao != null) {
      map['classificacao'] = Variable<String>(classificacao);
    }
    return map;
  }

  BsContatoCompanion toCompanion(bool nullToAbsent) {
    return BsContatoCompanion(
      id: Value(id),
      nome: nome == null && nullToAbsent ? const Value.absent() : Value(nome),
      telefone: telefone == null && nullToAbsent
          ? const Value.absent()
          : Value(telefone),
      endereco: endereco == null && nullToAbsent
          ? const Value.absent()
          : Value(endereco),
      classificacao: classificacao == null && nullToAbsent
          ? const Value.absent()
          : Value(classificacao),
    );
  }

  factory BsContatoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BsContatoData(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String?>(json['nome']),
      telefone: serializer.fromJson<String?>(json['telefone']),
      endereco: serializer.fromJson<String?>(json['endereco']),
      classificacao: serializer.fromJson<String?>(json['classificacao']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nome': serializer.toJson<String?>(nome),
      'telefone': serializer.toJson<String?>(telefone),
      'endereco': serializer.toJson<String?>(endereco),
      'classificacao': serializer.toJson<String?>(classificacao),
    };
  }

  BsContatoData copyWith(
          {int? id,
          Value<String?> nome = const Value.absent(),
          Value<String?> telefone = const Value.absent(),
          Value<String?> endereco = const Value.absent(),
          Value<String?> classificacao = const Value.absent()}) =>
      BsContatoData(
        id: id ?? this.id,
        nome: nome.present ? nome.value : this.nome,
        telefone: telefone.present ? telefone.value : this.telefone,
        endereco: endereco.present ? endereco.value : this.endereco,
        classificacao:
            classificacao.present ? classificacao.value : this.classificacao,
      );
  @override
  String toString() {
    return (StringBuffer('BsContatoData(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('telefone: $telefone, ')
          ..write('endereco: $endereco, ')
          ..write('classificacao: $classificacao')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nome, telefone, endereco, classificacao);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BsContatoData &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.telefone == this.telefone &&
          other.endereco == this.endereco &&
          other.classificacao == this.classificacao);
}

class BsContatoCompanion extends UpdateCompanion<BsContatoData> {
  final Value<int> id;
  final Value<String?> nome;
  final Value<String?> telefone;
  final Value<String?> endereco;
  final Value<String?> classificacao;
  const BsContatoCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.telefone = const Value.absent(),
    this.endereco = const Value.absent(),
    this.classificacao = const Value.absent(),
  });
  BsContatoCompanion.insert({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.telefone = const Value.absent(),
    this.endereco = const Value.absent(),
    this.classificacao = const Value.absent(),
  });
  static Insertable<BsContatoData> custom({
    Expression<int>? id,
    Expression<String>? nome,
    Expression<String>? telefone,
    Expression<String>? endereco,
    Expression<String>? classificacao,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nome != null) 'nome': nome,
      if (telefone != null) 'telefone': telefone,
      if (endereco != null) 'endereco': endereco,
      if (classificacao != null) 'classificacao': classificacao,
    });
  }

  BsContatoCompanion copyWith(
      {Value<int>? id,
      Value<String?>? nome,
      Value<String?>? telefone,
      Value<String?>? endereco,
      Value<String?>? classificacao}) {
    return BsContatoCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      telefone: telefone ?? this.telefone,
      endereco: endereco ?? this.endereco,
      classificacao: classificacao ?? this.classificacao,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (telefone.present) {
      map['telefone'] = Variable<String>(telefone.value);
    }
    if (endereco.present) {
      map['endereco'] = Variable<String>(endereco.value);
    }
    if (classificacao.present) {
      map['classificacao'] = Variable<String>(classificacao.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BsContatoCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('telefone: $telefone, ')
          ..write('endereco: $endereco, ')
          ..write('classificacao: $classificacao')
          ..write(')'))
        .toString();
  }
}

abstract class _$DbService extends GeneratedDatabase {
  _$DbService(QueryExecutor e) : super(e);
  late final BsContato bsContato = BsContato(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [bsContato];
}
