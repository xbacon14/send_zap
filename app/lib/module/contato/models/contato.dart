// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:drift/drift.dart';
import 'package:mobx/mobx.dart';
import 'package:send_zap/database/db_service.dart';
part 'contato.g.dart';

class Contato = ContatoBase with _$Contato;

abstract class ContatoBase with Store {
  int? id;
  String? nome;
  String? classificacao;
  String? telefone;
  String? endereco;
  @observable
  bool? selected = false;

  ContatoBase({
    this.id,
    this.nome,
    this.classificacao,
    this.telefone,
    this.endereco,
  });

  Contato copyWith({
    int? id,
    String? nome,
    String? classificacao,
    String? telefone,
    String? endereco,
  }) {
    return Contato(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      classificacao: classificacao ?? this.classificacao,
      telefone: telefone ?? this.telefone,
      endereco: endereco ?? this.endereco,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'classificacao': classificacao,
      'telefone': telefone,
      'endereco': endereco,
    };
  }

  ContatoBase.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'] != null ? map['nome'] as String : null;
    classificacao =
        map['classificacao'] != null ? map['classificacao'] as String : null;
    telefone = map['telefone'] != null ? map['telefone'] as String : null;
    endereco = map['endereco'] != null ? map['endereco'] as String : null;
  }

  isValid() {
    if (nome!.isEmpty) {
      return false;
    } else if (classificacao!.isEmpty) {
      return false;
    } else if (telefone!.isEmpty) {
      return false;
    } else if (endereco!.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  String toString() {
    return 'Contato(uuid: $id, nome: $nome, classificacao: $classificacao, telefone: $telefone, endereco: $endereco)';
  }

  @override
  bool operator ==(covariant Contato other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nome == nome &&
        other.classificacao == classificacao &&
        other.telefone == telefone &&
        other.endereco == endereco;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nome.hashCode ^
        classificacao.hashCode ^
        telefone.hashCode ^
        endereco.hashCode;
  }
}

class ContatoTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nome => text().withLength(min: 3, max: 32)();
  TextColumn get telefone => text().withLength(min: 6, max: 20)();
  TextColumn get endereco => text().withLength(min: 6, max: 50)();
  TextColumn get classificacao => text().withLength(min: 2, max: 32)();
}
