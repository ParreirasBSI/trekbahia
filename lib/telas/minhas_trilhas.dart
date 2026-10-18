import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trekbahia/componentes/cartao_trilha.dart';
import 'package:trekbahia/gerenciador_estado.dart';
import 'package:trekbahia/models/trilha.dart';
import 'package:trekbahia/repositorio.dart';

class MinhasTrilhas extends StatefulWidget {
  const MinhasTrilhas({super.key});

  @override
  State<MinhasTrilhas> createState() => _MinhasTrilhasState();
}

class _MinhasTrilhasState extends State<MinhasTrilhas> {
  List<Trilha> _todas = [];

  @override
  void initState() {
    super.initState();

    Repositorio.carregarTrilhas().then((trilhas) {
      if (mounted) {
        setState(() {
          _todas = trilhas;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final estadoApp = context.watch<GerenciadorEstado>();

    final favoritas = _todas
        .where((t) => estadoApp.favoritas.contains(t.id))
        .toList();
    final realizadas = _todas
        .where((t) => estadoApp.realizadas.contains(t.id))
        .toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => estadoApp.voltar(),
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text('Minhas trilhas'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Favoritas (${favoritas.length})'),
              Tab(text: 'Realizadas (${realizadas.length})'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _ListaTrilhas(
              trilhas: favoritas,
              vazio: 'Você ainda não favoritou nenhuma trilha.',
            ),
            _ListaTrilhas(
              trilhas: realizadas,
              vazio: 'Você ainda não marcou nenhuma trilha como realizada.',
            ),
          ],
        ),
      ),
    );
  }
}

class _ListaTrilhas extends StatelessWidget {
  final List<Trilha> trilhas;
  final String vazio;

  const _ListaTrilhas({required this.trilhas, required this.vazio});

  @override
  Widget build(BuildContext context) {
    if (trilhas.isEmpty) {
      return Center(child: Text(vazio));
    }

    return ListView.builder(
      itemCount: trilhas.length,
      itemBuilder: (context, index) => CartaoTrilha(trilha: trilhas[index]),
    );
  }
}
