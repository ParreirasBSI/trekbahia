import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:trekbahia/usuario.dart';

/// Login "mockado": confere e-mail e senha no arquivo usuarios.json.
class Autenticador {
  static Future<Usuario?> login(String email, String senha) async {
    final String conteudo = await rootBundle.loadString(
      'recursos/jsons/usuarios.json',
    );
    final dynamic dicionario = json.decode(conteudo);
    final List<dynamic> usuarios = dicionario['usuarios'];

    for (final u in usuarios) {
      if (u['email'].toString().toLowerCase() == email.trim().toLowerCase() &&
          u['senha'] == senha) {
        return Usuario(u['id'], u['nome'], u['email']);
      }
    }
    return null;
  }

  static Future<void> logout() async {
    // Nada a fazer: o login e apenas simulado.
  }
}
