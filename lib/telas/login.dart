import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trekbahia/autenticador.dart';
import 'package:trekbahia/avisos.dart';
import 'package:trekbahia/gerenciador_estado.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formulario = GlobalKey<FormState>();
  final TextEditingController _controladorEmail = TextEditingController();
  final TextEditingController _controladorSenha = TextEditingController();

  bool _enviando = false;
  String? _erro;

  @override
  void dispose() {
    _controladorEmail.dispose();
    _controladorSenha.dispose();
    super.dispose();
  }

  Future<void> _entrar() async {
    if (!_formulario.currentState!.validate()) return;

    setState(() {
      _enviando = true;
      _erro = null;
    });

    final usuario = await Autenticador.login(
      _controladorEmail.text,
      _controladorSenha.text,
    );

    if (!mounted) return;

    if (usuario == null) {
      setState(() {
        _enviando = false;
        _erro = 'E-mail ou senha inválidos.';
      });
      return;
    }

    final estadoApp = context.read<GerenciadorEstado>();

    avisar(context, 'Você foi conectado com sucesso');

    estadoApp.login(usuario);
    estadoApp.voltar();
  }

  @override
  Widget build(BuildContext context) {
    final estadoApp = context.read<GerenciadorEstado>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => estadoApp.voltar(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Entrar'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formulario,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.terrain, size: 72),
                const SizedBox(height: 8),
                Text(
                  'TrekBahia',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _controladorEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Informe o e-mail' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _controladorSenha,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Informe a senha' : null,
                ),
                if (_erro != null) ...[
                  const SizedBox(height: 12),
                  Text(_erro!, style: const TextStyle(color: Colors.red)),
                ],
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _enviando ? null : _entrar,
                    child: _enviando
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Entrar'),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Demonstração: ana@trekbahia.com / 123456',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
