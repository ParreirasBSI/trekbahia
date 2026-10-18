import 'package:flutter/material.dart';

/// Botoes que so aparecem para o usuario logado (favoritar e marcar realizada).
class ControlesUsuario extends StatelessWidget {
  final bool usuarioLogado;
  final bool favorita;
  final bool realizada;

  final void Function() onFavoritar;
  final void Function() onRealizar;
  final void Function() onEntrar;

  const ControlesUsuario({
    super.key,
    required this.usuarioLogado,
    required this.favorita,
    required this.realizada,
    required this.onFavoritar,
    required this.onRealizar,
    required this.onEntrar,
  });

  @override
  Widget build(BuildContext context) {
    if (!usuarioLogado) {
      return Card(
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'Entre para favoritar e marcar as trilhas que você já fez.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              FilledButton(onPressed: onEntrar, child: const Text('Entrar')),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onFavoritar,
            icon: Icon(
              favorita ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            label: Text(favorita ? 'Remover dos favoritos' : 'Favoritar'),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: onRealizar,
            icon: Icon(realizada ? Icons.check_circle : Icons.flag_outlined),
            label: Text(
              realizada ? 'Já realizei esta trilha' : 'Marcar como realizada',
            ),
          ),
        ),
      ],
    );
  }
}
