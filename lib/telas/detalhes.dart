import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trekbahia/avisos.dart';
import 'package:trekbahia/componentes/controles_usuario.dart';
import 'package:trekbahia/componentes/selo_dificuldade.dart';
import 'package:trekbahia/gerenciador_estado.dart';
import 'package:trekbahia/models/trilha.dart';
import 'package:trekbahia/repositorio.dart';

class Detalhes extends StatefulWidget {
  const Detalhes({super.key});

  @override
  State<Detalhes> createState() => _DetalhesState();
}

class _DetalhesState extends State<Detalhes> {
  Trilha? _trilha;

  @override
  void initState() {
    super.initState();

    _carregarTrilha();
  }

  Future<void> _carregarTrilha() async {
    final idTrilha = context.read<GerenciadorEstado>().idTrilha;
    final trilhas = await Repositorio.carregarTrilhas();

    if (!mounted) return;

    setState(() {
      _trilha = trilhas.firstWhere((t) => t.id == idTrilha);
    });
  }

  @override
  Widget build(BuildContext context) {
    final estadoApp = context.watch<GerenciadorEstado>();
    final trilha = _trilha;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => estadoApp.voltar(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(trilha?.nome ?? 'Detalhes'),
      ),
      body: trilha == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Row(
                  children: [
                    SeloDificuldade(dificuldade: trilha.dificuldade),
                    const SizedBox(width: 12),
                    Expanded(child: Text('${trilha.cidade} • ${trilha.regiao}')),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _InfoCard(
                        icone: Icons.straighten,
                        titulo: 'Distância',
                        valor: '${trilha.distanciaKm} km',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _InfoCard(
                        icone: Icons.schedule,
                        titulo: 'Duração',
                        valor: trilha.duracao,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text('Sobre', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 6),
                Text(trilha.descricao),
                const SizedBox(height: 20),
                Text('Dicas', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 6),
                ...trilha.dicas.map(
                  (d) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle_outline, size: 18),
                        const SizedBox(width: 8),
                        Expanded(child: Text(d)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ControlesUsuario(
                  usuarioLogado: estadoApp.logado,
                  favorita: estadoApp.favoritas.contains(trilha.id),
                  realizada: estadoApp.realizadas.contains(trilha.id),
                  onFavoritar: () {
                    final eraFavorita = estadoApp.favoritas.contains(trilha.id);
                    estadoApp.alternarFavorita(trilha.id);
                    avisar(
                      context,
                      eraFavorita
                          ? 'Removida dos favoritos'
                          : 'Adicionada aos favoritos',
                    );
                  },
                  onRealizar: () {
                    final eraRealizada = estadoApp.realizadas.contains(trilha.id);
                    estadoApp.alternarRealizada(trilha.id);
                    avisar(
                      context,
                      eraRealizada
                          ? 'Trilha desmarcada'
                          : 'Trilha marcada como realizada!',
                    );
                  },
                  onEntrar: () => estadoApp.exibirLogin(),
                ),
              ],
            ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String valor;

  const _InfoCard({
    required this.icone,
    required this.titulo,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icone),
            const SizedBox(height: 4),
            Text(titulo, style: Theme.of(context).textTheme.labelSmall),
            const SizedBox(height: 2),
            Text(
              valor,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
