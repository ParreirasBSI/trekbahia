import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:trekbahia/models/trilha.dart';

/// Simula o acesso a dados lendo o arquivo JSON estatico.
class Repositorio {
  static Future<List<Trilha>> carregarTrilhas() async {
    final String conteudo = await rootBundle.loadString(
      'recursos/jsons/trilhas.json',
    );
    final dynamic dicionario = json.decode(conteudo);
    final List<dynamic> lista = dicionario['trilhas'];

    return lista
        .map((item) => Trilha.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
