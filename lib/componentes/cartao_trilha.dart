import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trekbahia/componentes/selo_dificuldade.dart';
import 'package:trekbahia/gerenciador_estado.dart';
import 'package:trekbahia/models/trilha.dart';

class CartaoTrilha extends StatelessWidget {
  final Trilha trilha;

  const CartaoTrilha({super.key, required this.trilha});

  @override
  Widget build(BuildContext context) {
    final cor = corDaDificuldade(trilha.dificuldade);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundColor: cor.withAlpha(40),
          child: Icon(Icons.terrain, color: cor),
        ),
        title: Text(
          trilha.nome,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text('${trilha.cidade} • ${trilha.distanciaKm} km'),
        ),
        trailing: SeloDificuldade(dificuldade: trilha.dificuldade),
        onTap: () => context.read<GerenciadorEstado>().exibirDetalhes(trilha.id),
      ),
    );
  }
}
