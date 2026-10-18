class Trilha {
  final int id;
  final String nome;
  final String cidade;
  final String regiao;
  final String dificuldade;
  final double distanciaKm;
  final String duracao;
  final String descricao;
  final List<String> dicas;

  const Trilha({
    required this.id,
    required this.nome,
    required this.cidade,
    required this.regiao,
    required this.dificuldade,
    required this.distanciaKm,
    required this.duracao,
    required this.descricao,
    required this.dicas,
  });

  factory Trilha.fromJson(Map<String, dynamic> json) {
    return Trilha(
      id: json['id'] as int,
      nome: json['nome'] as String,
      cidade: json['cidade'] as String,
      regiao: json['regiao'] as String,
      dificuldade: json['dificuldade'] as String,
      distanciaKm: (json['distanciaKm'] as num).toDouble(),
      duracao: json['duracao'] as String,
      descricao: json['descricao'] as String,
      dicas: List<String>.from(json['dicas'] as List),
    );
  }
}
