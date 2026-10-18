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

Pré-requisitos: Flutter instalado e Android SDK configurado (confira com `flutter doctor`).

O app foi testado em um **celular Android físico** (Samsung Galaxy S25 FE), sem usar o emulador do Android SDK.

1. No celular, ative as **Opções do desenvolvedor** e a **Depuração USB**.
2. Conecte o celular ao computador por cabo USB e aceite o aviso "Permitir depuração USB".
3. No terminal, dentro da pasta do projeto:

```bash
flutter pub get
flutter devices          # o celular deve aparecer na lista
flutter run --release
```

Também é possível rodar em um emulador Android (`flutter run`) ou no navegador (`flutter run -d chrome`).

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
