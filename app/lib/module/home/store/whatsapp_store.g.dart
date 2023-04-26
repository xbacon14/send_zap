// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'whatsapp_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WhatsappStore on WhatsappStoreBase, Store {
  late final _$selectAllAtom =
      Atom(name: 'WhatsappStoreBase.selectAll', context: context);

  @override
  bool get selectAll {
    _$selectAllAtom.reportRead();
    return super.selectAll;
  }

  @override
  set selectAll(bool value) {
    _$selectAllAtom.reportWrite(value, super.selectAll, () {
      super.selectAll = value;
    });
  }

  @override
  String toString() {
    return '''
selectAll: ${selectAll}
    ''';
  }
}
