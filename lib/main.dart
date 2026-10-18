import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trekbahia/gerenciador_estado.dart';
import 'package:trekbahia/telas/detalhes.dart';
import 'package:trekbahia/telas/login.dart';
import 'package:trekbahia/telas/minhas_trilhas.dart';
import 'package:trekbahia/telas/trilhas.dart';

void main() {
  runApp(const TrekBahia());
}

class TrekBahia extends StatelessWidget {
  const TrekBahia({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GerenciadorEstado(),
      child: MaterialApp(
        title: 'TrekBahia',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D32)),
        ),
        home: const TelaPrincipal(),
      ),
    );
  }
}

class TelaPrincipal extends StatelessWidget {
  const TelaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    final estadoApp = context.watch<GerenciadorEstado>();

    Widget tela = const SizedBox.shrink();
    if (estadoApp.exibicao == EmExibicao.telaTrilhas) {
      tela = const Trilhas();
    } else if (estadoApp.exibicao == EmExibicao.telaDetalhes) {
      tela = const Detalhes();
    } else if (estadoApp.exibicao == EmExibicao.telaLogin) {
      tela = const Login();
    } else if (estadoApp.exibicao == EmExibicao.telaMinhasTrilhas) {
      tela = const MinhasTrilhas();
    }

    // Botao "voltar" do celular volta para a tela anterior do app.
    return PopScope(
      canPop: estadoApp.exibicao == EmExibicao.telaTrilhas,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          estadoApp.voltar();
        }
      },
      child: tela,
    );
  }
}
