/// Wrappers de navegação com suporte a confirmação de saída.
///
/// Este módulo fornece funções para navegação segura que respeitam
/// as configurações de confirmação de saída.
///
/// **Nota:** Para a API moderna, prefira usar as extensões de contexto
/// em `navegacao_context_ext.dart` ou o `ServicoNavegacao`.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/navigation_provider.dart';

// =============================================================================
// TIPOS E ENUMS
// =============================================================================

/// Tipo de navegação a ser executada.
enum _TipoNavegacao { go, goNamed, push, pushNamed, pop }

/// Parâmetros para navegação.
class _ParametrosNavegacao {
  final String? location;
  final String? name;
  final Map<String, String> pathParameters;
  final Map<String, dynamic> queryParameters;
  final Object? extra;

  const _ParametrosNavegacao({
    this.location,
    this.name,
    this.pathParameters = const {},
    this.queryParameters = const {},
    this.extra,
  });
}

// =============================================================================
// HELPERS INTERNOS
// =============================================================================

/// Desativa a confirmação de saída de forma segura.
void _desativarConfirmacao(BuildContext context) {
  try {
    final container = ProviderScope.containerOf(context, listen: false);
    final atual = container.read(confirmacaoSaidaProvider);
    container.read(confirmacaoSaidaProvider.notifier).state = atual.copiarCom(
      obrigatorio: false,
    );
  } catch (_) {
    // Continua mesmo se falhar
  }
}

/// Mostra o diálogo de confirmação de saída.
Future<({bool confirmado, BuildContext? dialogContext})> _mostrarDialogo(
  BuildContext context,
  ConfiguracaoConfirmacaoSaida config,
) async {
  BuildContext? dialogContext;

  final resultado = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      dialogContext = ctx;
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(
              Icons.exit_to_app,
              color: Theme.of(ctx).colorScheme.primary,
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                config.titulo,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(ctx).colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            config.conteudo,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(ctx).colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(ctx).colorScheme.onSurface,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: Text(
              config.textoCancelar,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.primary,
              foregroundColor: Theme.of(ctx).colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              config.textoConfirmar,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        contentPadding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
        titlePadding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
      );
    },
  );

  return (confirmado: resultado ?? false, dialogContext: dialogContext);
}

/// Executa a navegação baseada no tipo.
Future<bool> _executarNavegacao(
  BuildContext context,
  _TipoNavegacao tipo,
  _ParametrosNavegacao params,
) async {
  switch (tipo) {
    case _TipoNavegacao.go:
      context.go(params.location!, extra: params.extra);
      return true;

    case _TipoNavegacao.goNamed:
      context.goNamed(
        params.name!,
        pathParameters: params.pathParameters,
        queryParameters: params.queryParameters,
        extra: params.extra,
      );
      return true;

    case _TipoNavegacao.push:
      await context.push(params.location!, extra: params.extra);
      return true;

    case _TipoNavegacao.pushNamed:
      await context.pushNamed(
        params.name!,
        pathParameters: params.pathParameters,
        queryParameters: params.queryParameters,
        extra: params.extra,
      );
      return true;

    case _TipoNavegacao.pop:
      context.pop();
      return true;
  }
}

/// Função genérica que executa navegação com verificação de confirmação.
///
/// Esta função centraliza toda a lógica de navegação segura,
/// eliminando a duplicação de código entre as funções públicas.
Future<bool> _navegarComConfirmacao({
  required BuildContext context,
  required WidgetRef ref,
  required _TipoNavegacao tipo,
  required _ParametrosNavegacao params,
}) async {
  if (!context.mounted) return false;

  final configSaida = ref.read(confirmacaoSaidaProvider);

  // Se não precisa de confirmação, navega direto
  if (!configSaida.obrigatorio) {
    return _executarNavegacao(context, tipo, params);
  }

  // Mostra diálogo de confirmação
  final resultado = await _mostrarDialogo(context, configSaida);
  if (!resultado.confirmado) return false;

  // Usa o contexto do diálogo se disponível
  final navContext = resultado.dialogContext ?? context;
  if (!navContext.mounted) return false;

  // Desativa confirmação e navega
  _desativarConfirmacao(navContext);

  return Future.microtask(() {
    if (!navContext.mounted) return false;
    return _executarNavegacao(navContext, tipo, params);
  });
}

// =============================================================================
// API PÚBLICA - NAVEGAÇÃO SEGURA (COM CONFIRMAÇÃO)
// =============================================================================

/// Navega para um caminho com verificação de confirmação de saída.
Future<bool> safeGo({
  required BuildContext context,
  required WidgetRef ref,
  required String location,
  Object? extra,
}) => _navegarComConfirmacao(
  context: context,
  ref: ref,
  tipo: _TipoNavegacao.go,
  params: _ParametrosNavegacao(location: location, extra: extra),
);

/// Navega para uma rota nomeada com verificação de confirmação de saída.
Future<bool> safeGoNamed({
  required BuildContext context,
  required WidgetRef ref,
  required String name,
  Map<String, String> pathParameters = const {},
  Map<String, dynamic> queryParameters = const {},
  Object? extra,
}) => _navegarComConfirmacao(
  context: context,
  ref: ref,
  tipo: _TipoNavegacao.goNamed,
  params: _ParametrosNavegacao(
    name: name,
    pathParameters: pathParameters,
    queryParameters: queryParameters,
    extra: extra,
  ),
);

/// Push de um caminho com verificação de confirmação de saída.
Future<bool> safePush({
  required BuildContext context,
  required WidgetRef ref,
  required String location,
  Object? extra,
}) => _navegarComConfirmacao(
  context: context,
  ref: ref,
  tipo: _TipoNavegacao.push,
  params: _ParametrosNavegacao(location: location, extra: extra),
);

/// Push de uma rota nomeada com verificação de confirmação de saída.
Future<bool> safePushNamed({
  required BuildContext context,
  required WidgetRef ref,
  required String name,
  Map<String, String> pathParameters = const {},
  Map<String, dynamic> queryParameters = const {},
  Object? extra,
}) => _navegarComConfirmacao(
  context: context,
  ref: ref,
  tipo: _TipoNavegacao.pushNamed,
  params: _ParametrosNavegacao(
    name: name,
    pathParameters: pathParameters,
    queryParameters: queryParameters,
    extra: extra,
  ),
);

/// Volta para a rota anterior com verificação de confirmação de saída.
Future<bool> safePop({required BuildContext context, required WidgetRef ref}) =>
    _navegarComConfirmacao(
      context: context,
      ref: ref,
      tipo: _TipoNavegacao.pop,
      params: const _ParametrosNavegacao(),
    );

/// Verifica se é possível voltar (pop).
bool canPop({required BuildContext context}) {
  if (!context.mounted) return false;
  return GoRouter.of(context).canPop();
}

// =============================================================================
// API PÚBLICA - NAVEGAÇÃO DIRETA (SEM CONFIRMAÇÃO)
// =============================================================================

/// Navega para um caminho SEM verificação de confirmação.
bool unsafeGo({
  required BuildContext context,
  required String location,
  Object? extra,
}) {
  if (!context.mounted) return false;
  context.go(location, extra: extra);
  return true;
}

/// Navega para uma rota nomeada SEM verificação de confirmação.
bool unsafeGoNamed({
  required BuildContext context,
  required String name,
  Map<String, String> pathParameters = const {},
  Map<String, dynamic> queryParameters = const {},
  Object? extra,
}) {
  if (!context.mounted) return false;
  context.goNamed(
    name,
    pathParameters: pathParameters,
    queryParameters: queryParameters,
    extra: extra,
  );
  return true;
}

/// Push de um caminho SEM verificação de confirmação.
Future<bool> unsafePush({
  required BuildContext context,
  required String location,
  Object? extra,
}) async {
  if (!context.mounted) return false;
  await context.push(location, extra: extra);
  return true;
}

/// Push de uma rota nomeada SEM verificação de confirmação.
Future<bool> unsafePushNamed({
  required BuildContext context,
  required String name,
  Map<String, String> pathParameters = const {},
  Map<String, dynamic> queryParameters = const {},
  Object? extra,
}) async {
  if (!context.mounted) return false;
  await context.pushNamed(
    name,
    pathParameters: pathParameters,
    queryParameters: queryParameters,
    extra: extra,
  );
  return true;
}

/// Volta para a rota anterior SEM verificação de confirmação.
Future<bool> unsafePop({required BuildContext context}) async {
  if (!context.mounted) return false;
  context.pop();
  return true;
}
