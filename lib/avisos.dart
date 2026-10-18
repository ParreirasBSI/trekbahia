import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

/// Mostra uma mensagem rapida (Toast) na parte de baixo da tela.
void avisar(BuildContext context, String mensagem) {
  ToastContext().init(context);

  Toast.show(mensagem, duration: Toast.lengthLong, gravity: Toast.bottom);
}
