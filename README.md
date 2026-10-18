# TrekBahia

App de trilhas e cachoeiras da Bahia (Chapada Diamantina).
Avaliação I — Programação Móvel — IFBA Campus Vitória da Conquista.
Feito em **Dart + Flutter**, com `provider` para o estado e `toast` para os avisos (mesmos recursos vistos em aula).

## Funcionalidades

- **Sem login:** lista de trilhas, busca por nome/cidade, filtro por dificuldade, pull-to-refresh e tela de detalhes (distância, duração, descrição e dicas).
- **Com login (mockado):** favoritar trilhas, marcar como realizada e tela **Minhas trilhas** (abas Favoritas e Realizadas).
- **Login/logoff:** ícone no cabeçalho da lista (entrar / sair).
- **Dados:** arquivos JSON estáticos em `recursos/jsons/` (`trilhas.json` e `usuarios.json`).

## Usuários de teste

| E-mail | Senha |
|---|---|
| ana@trekbahia.com | 123456 |
| carlos@trekbahia.com | 123456 |

## Como executar

```bash
flutter create --project-name trekbahia .   # gera as pastas android/ios (uma vez)
flutter pub get
flutter run                                  # com o emulador do Android SDK aberto
```

## Estrutura

```
lib/
  main.dart                  # Provider + escolha da tela pelo estado
  gerenciador_estado.dart    # ChangeNotifier: tela atual, usuário, favoritas, realizadas
  autenticador.dart          # login mockado (lê usuarios.json)
  repositorio.dart           # lê trilhas.json
  usuario.dart, avisos.dart
  models/trilha.dart
  telas/                     # trilhas, detalhes, login, minhas_trilhas
  componentes/               # cartao_trilha, controles_usuario, selo_dificuldade
recursos/jsons/              # trilhas.json, usuarios.json
```

Observação: distâncias e durações das trilhas são aproximadas e usadas apenas para fins didáticos.
