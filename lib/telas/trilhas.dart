import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trekbahia/autenticador.dart';
import 'package:trekbahia/avisos.dart';
import 'package:trekbahia/componentes/cartao_trilha.dart';
import 'package:trekbahia/gerenciador_estado.dart';
import 'package:trekbahia/models/trilha.dart';
import 'package:trekbahia/repositorio.dart';

class Trilhas extends StatefulWidget {
  const Trilhas({super.key});

  @override
  State<Trilhas> createState() => _TrilhasState();
}

class _TrilhasState extends State<Trilhas> {
  static const List<String> _dificuldades = [
    'Todas',
    'Fácil',
    'Moderada',
    'Difícil',
  ];

  List<Trilha> _trilhas = [];
  bool _carregandoTrilhas = false;
  String _filtro = '';
  String _dificuldade = 'Todas';

  final TextEditingController _controladorFiltro = TextEditingController();

  @override
  void initState() {
    super.initState();

    _carregarTrilhas();
  }

  @override
  void dispose() {
    _controladorFiltro.dispose();
    super.dispose();
  }

  Future<void> _carregarTrilhas() async {
    setState(() {
      _carregandoTrilhas = true;
    });

    final trilhas = await Repositorio.carregarTrilhas();

    if (!mounted) return;

    setState(() {
      _trilhas = trilhas;
      _carregandoTrilhas = false;
    });
  }

  Future<void> _atualizarTrilhas() async {
    _controladorFiltro.text = '';
    _filtro = '';
    _dificuldade = 'Todas';

    await _carregarTrilhas();
  }

  List<Trilha> get _trilhasFiltradas {
    final texto = _filtro.toLowerCase();

    return _trilhas.where((t) {
      final combinaTexto =
          t.nome.toLowerCase().contains(texto) ||
          t.cidade.toLowerCase().contains(texto);
      final combinaDificuldade =
          _dificuldade == 'Todas' || t.dificuldade == _dificuldade;

      return combinaTexto && combinaDificuldade;
    }).toList();
  }

  Future<void> _sair(GerenciadorEstado estadoApp) async {
    await Autenticador.logout();

    estadoApp.logout();

    if (mounted) {
      avisar(context, 'Você foi desconectado com sucesso');
    }
  }

  @override
  Widget build(BuildContext context) {
    final estadoApp = context.watch<GerenciadorEstado>();
    final trilhas = _trilhasFiltradas;

    return Scaffold(
      appBar: AppBar(
        title: const Text('TrekBahia'),
        actions: [
          if (estadoApp.logado)
            IconButton(
              tooltip: 'Minhas trilhas',
              onPressed: () => estadoApp.exibirMinhasTrilhas(),
              icon: const Icon(Icons.bookmark),
            ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: estadoApp.logado
                ? IconButton(
                    tooltip: 'Sair',
                    onPressed: () => _sair(estadoApp),
                    icon: const Icon(Icons.logout),
                  )
                : IconButton(
                    tooltip: 'Entrar',
                    onPressed: () => estadoApp.exibirLogin(),
                    icon: const Icon(Icons.login),
                  ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: TextField(
              controller: _controladorFiltro,
              onChanged: (filtro) => setState(() => _filtro = filtro),
              decoration: const InputDecoration(
                hintText: 'Buscar por trilha ou cidade',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
                isDense: true,
              ),
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: _dificuldades
                  .map(
                    (d) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        label: Text(d),
                        selected: _dificuldade == d,
                        onSelected: (_) => setState(() => _dificuldade = d),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: _carregandoTrilhas
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: _atualizarTrilhas,
                    child: trilhas.isEmpty
                        ? ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: const [
                              SizedBox(height: 120),
                              Center(child: Text('Nenhuma trilha encontrada.')),
                            ],
                          )
                        : ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: trilhas.length,
                            itemBuilder: (context, index) {
                              return CartaoTrilha(trilha: trilhas[index]);
                            },
                          ),
                  ),
          ),
        ],
      ),
    );
  }
}
