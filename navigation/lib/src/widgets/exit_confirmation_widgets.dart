import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Widget que envolve seu app e fornece confirmação de saída.
///
/// Este widget intercepta eventos de navegação (como botão voltar no Android)
/// e mostra um diálogo de confirmação antes de permitir a saída.
///
/// Exemplo de uso:
/// ```dart
/// ConfirmacaoSaida(
///   child: MaterialApp.router(
///     routerConfig: ref.watch(routerProvider),
///   ),
///   aoConfirmarSaida: () {
///     // Opcional: lógica adicional antes de sair
///     return true;
///   },
///   titulo: 'Sair do aplicativo?',
///   conteudo: 'Tem certeza de que deseja sair?',
/// )
/// ```
class ConfirmacaoSaida extends ConsumerWidget {
  /// O widget filho que será envolvido.
  final Widget filho;

  /// Callback opcional chamado quando o usuário confirma a saída.
  /// Retorna `true` para permitir saída, `false` para cancelar.
  final bool Function()? aoConfirmarSaida;

  /// Título do diálogo de confirmação.
  final String titulo;

  /// Conteúdo do diálogo de confirmação.
  final String conteudo;

  /// Texto do botão de confirmação.
  final String textoConfirmar;

  /// Texto do botão de cancelamento.
  final String textoCancelar;

  /// Estilo do botão de confirmação.
  final ButtonStyle? estiloBotaoConfirmar;

  /// Estilo do botão de cancelamento.
  final ButtonStyle? estiloBotaoCancelar;

  const ConfirmacaoSaida({
    super.key,
    required this.filho,
    this.aoConfirmarSaida,
    this.titulo = 'Sair do aplicativo?',
    this.conteudo = 'Tem certeza de que deseja sair?',
    this.textoConfirmar = 'Sair',
    this.textoCancelar = 'Cancelar',
    this.estiloBotaoConfirmar,
    this.estiloBotaoCancelar,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final deveSair = await _mostrarConfirmacaoSaida(context);
        if (deveSair && context.mounted) {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          } else {
            // Se não houver rotas anteriores, fecha o app
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else {
              exit(0);
            }
          }
        }
      },
      child: filho,
    );
  }

  Future<bool> _mostrarConfirmacaoSaida(BuildContext context) async {
    final resultado = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(conteudo),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              style: estiloBotaoCancelar,
              child: Text(textoCancelar),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style:
                  estiloBotaoConfirmar ??
                  TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text(textoConfirmar),
            ),
          ],
        );
      },
    );

    if (resultado == true) {
      // Se houver um callback customizado, verifica se devemos prosseguir
      if (aoConfirmarSaida != null) {
        return aoConfirmarSaida!();
      }
      return true;
    }

    return false;
  }
}

// Alias para compatibilidade com código existente
class ExitConfirmation extends ConfirmacaoSaida {
  const ExitConfirmation({
    super.key,
    required Widget child,
    bool Function()? onConfirmExit,
    String title = 'Sair do aplicativo?',
    String content = 'Tem certeza de que deseja sair?',
    String confirmText = 'Sair',
    String cancelText = 'Cancelar',
    ButtonStyle? confirmButtonStyle,
    ButtonStyle? cancelButtonStyle,
  }) : super(
         filho: child,
         aoConfirmarSaida: onConfirmExit,
         titulo: title,
         conteudo: content,
         textoConfirmar: confirmText,
         textoCancelar: cancelText,
         estiloBotaoConfirmar: confirmButtonStyle,
         estiloBotaoCancelar: cancelButtonStyle,
       );
}
