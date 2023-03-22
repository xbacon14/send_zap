// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contato.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Contato on ContatoBase, Store {
  late final _$selectedAtom =
      Atom(name: 'ContatoBase.selected', context: context);

  @override
  bool? get selected {
    _$selectedAtom.reportRead();
    return super.selected;
  }

  @override
  set selected(bool? value) {
    _$selectedAtom.reportWrite(value, super.selected, () {
      super.selected = value;
    });
  }

  @override
  String toString() {
    return '''
selected: ${selected}
    ''';
  }
}
