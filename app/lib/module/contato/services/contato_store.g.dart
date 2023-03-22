// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contato_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ContatoStore on ContatoStoreBase, Store {
  late final _$dataProviderAtom =
      Atom(name: 'ContatoStoreBase.dataProvider', context: context);

  @override
  ObservableList<Contato> get dataProvider {
    _$dataProviderAtom.reportRead();
    return super.dataProvider;
  }

  @override
  set dataProvider(ObservableList<Contato> value) {
    _$dataProviderAtom.reportWrite(value, super.dataProvider, () {
      super.dataProvider = value;
    });
  }

  @override
  String toString() {
    return '''
dataProvider: ${dataProvider}
    ''';
  }
}
