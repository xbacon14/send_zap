// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:send_zap/module/contato/models/contato.dart';

class ImportacaoContatoDto {
  List<Contato> Hoja1;
  ImportacaoContatoDto({
    required this.Hoja1,
  });

  ImportacaoContatoDto copyWith({
    List<Contato>? Hoja1,
  }) {
    return ImportacaoContatoDto(
      Hoja1: Hoja1 ?? this.Hoja1,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Hoja1': Hoja1.map((x) => x.toMap()).toList(),
    };
  }

  factory ImportacaoContatoDto.fromMap(Map<String, dynamic> map) {
    return ImportacaoContatoDto(
      Hoja1: List<Contato>.from(
        (map['Hoja1'] as List<int>).map<Contato>(
          (x) => Contato.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ImportacaoContatoDto.fromJson(String source) =>
      ImportacaoContatoDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ImportacaoContatoDto(Hoja1: $Hoja1)';

  @override
  bool operator ==(covariant ImportacaoContatoDto other) {
    if (identical(this, other)) return true;

    return listEquals(other.Hoja1, Hoja1);
  }

  @override
  int get hashCode => Hoja1.hashCode;
}
