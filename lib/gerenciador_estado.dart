import 'package:flutter/material.dart';
import 'package:trekbahia/usuario.dart';

enum EmExibicao { telaTrilhas, telaDetalhes, telaLogin, telaMinhasTrilhas }

class GerenciadorEstado extends ChangeNotifier {
  EmExibicao _exibicao = EmExibicao.telaTrilhas;
  EmExibicao get exibicao => _exibicao;

  // Pilha simples para o botao "voltar".
  final List<EmExibicao> _pilha = [];

  int _idTrilha = -1;
  int get idTrilha => _idTrilha;

  Usuario? _usuario;
  Usuario? get usuario => _usuario;
  bool get logado => _usuario != null;

  // Favoritas e realizadas de cada usuario (guardadas em memoria).
  final Map<String, Set<int>> _favoritas = {};
  final Map<String, Set<int>> _realizadas = {};

  Set<int> get favoritas => _favoritas[_usuario?.id] ?? <int>{};
  Set<int> get realizadas => _realizadas[_usuario?.id] ?? <int>{};

  void _navegar(EmExibicao destino) {
    _pilha.add(_exibicao);
    _exibicao = destino;

    notifyListeners();
  }

  void exibirTrilhas() {
    _pilha.clear();
    _exibicao = EmExibicao.telaTrilhas;

    notifyListeners();
  }

  void exibirDetalhes(int idTrilha) {
    _idTrilha = idTrilha;

    _navegar(EmExibicao.telaDetalhes);
  }

  void exibirLogin() => _navegar(EmExibicao.telaLogin);

  void exibirMinhasTrilhas() => _navegar(EmExibicao.telaMinhasTrilhas);

  void voltar() {
    if (_pilha.isNotEmpty) {
      _exibicao = _pilha.removeLast();
    } else {
      _exibicao = EmExibicao.telaTrilhas;
    }

    notifyListeners();
  }

  void login(Usuario? usuario) {
    _usuario = usuario;

    notifyListeners();
  }

  void logout() {
    _usuario = null;

    notifyListeners();
  }

  void alternarFavorita(int idTrilha) {
    _alternar(_favoritas, idTrilha);
  }

  void alternarRealizada(int idTrilha) {
    _alternar(_realizadas, idTrilha);
  }

  void _alternar(Map<String, Set<int>> mapa, int idTrilha) {
    final usuario = _usuario;
    if (usuario == null) return;

    final conjunto = mapa.putIfAbsent(usuario.id, () => <int>{});
    if (!conjunto.remove(idTrilha)) {
      conjunto.add(idTrilha);
    }

    notifyListeners();
  }
}
