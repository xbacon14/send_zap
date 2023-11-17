import 'dart:convert';

import 'package:excel_to_json/excel_to_json.dart';
import 'package:flutter/foundation.dart';
import 'package:send_zap/module/contato/models/contato.dart';
import 'dart:developer' as dev;

class ContatoService {
  static Future<List<Contato>> convertFileResultToContato() async {
    List<Contato> lista = [];
    String? excel = await ExcelToJson().convert();
    if (excel != null) {
      final result = jsonDecode(excel);
      debugPrint('result: ${result.toString()}');
      lista = result['Hoja1'].map<Contato>((c) => Contato.fromMap(c)).toList();
    }
    // List<String?> strings = lista.map((e) => e.telefone).toList();
    // strings.map((telefono) => telefono!.replaceAll(RegExp(r'[^\d]+'), ''));
    // strings.map((telefono) =>
    //     telefono!.startsWith("+595") ? telefono : "+595$telefono");
    List<int> indexToRemove = [];
    int tamanhoImportacion = lista.length;
    for (var i = 0; i < lista.length; i++) {
      // VALIDA ENDERECO
      lista[i].endereco = lista[i].endereco == null ? "" : lista[i].endereco;

      // VALIDA NRO TELEFONE
      if (!lista[i].telefone!.startsWith('595')) {
        lista[i].telefone = lista[i].telefone!.startsWith("0")
            ? lista[i].telefone!.replaceFirst("0", "")
            : lista[i].telefone;
        lista[i].telefone =
            lista[i].telefone!.replaceAll(RegExp(r'[^\d]+'), '');
        lista[i].telefone = lista[i].telefone!.startsWith("+595")
            ? lista[i].telefone
            : "+595${lista[i].telefone}";
        if (lista[i].telefone!.length != 13) {
          indexToRemove.add(i);
        }
      }
    }
    if (indexToRemove.isNotEmpty) {
      for (var j = 0; j < indexToRemove.length; j++) {
        lista.removeAt(indexToRemove[j]);
      }
    }
    dev.inspect(lista);
    debugPrint(
        "la lista quedó con ${lista.length} contactos de los $tamanhoImportacion importados");
    return await lista;
  }
}
