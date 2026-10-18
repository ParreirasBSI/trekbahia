import 'package:flutter/material.dart';

Color corDaDificuldade(String dificuldade) {
  switch (dificuldade) {
    case 'Fácil':
      return Colors.green;
    case 'Moderada':
      return Colors.orange;
    default:
      return Colors.red;
  }
}

class SeloDificuldade extends StatelessWidget {
  final String dificuldade;

  const SeloDificuldade({super.key, required this.dificuldade});

  @override
  Widget build(BuildContext context) {
    final cor = corDaDificuldade(dificuldade);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: cor.withAlpha(40),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cor),
      ),
      child: Text(
        dificuldade,
        style: TextStyle(color: cor, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}
