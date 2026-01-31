/// Observer de navegação para analytics e logging.
///
/// Permite interceptar eventos de navegação para:
/// - Logging de debug
/// - Envio de analytics
/// - Rastreamento de usuário
library;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Callback para eventos de navegação.
typedef CallbackNavegacao =
    void Function(Route<dynamic> rota, Route<dynamic>? rotaAnterior);

/// Callback para analytics.
typedef CallbackAnalytics =
    void Function(String nomeRota, Map<String, dynamic> parametros);

/// Observer customizado para navegação do RouterCore.
///
/// Permite interceptar push, pop, replace e remove de rotas
/// para logging, analytics ou qualquer processamento customizado.
///
/// Uso:
/// ```dart
/// final observer = ObserverNavegacao(
///   aoNavegar: (rota, anterior) => print('Navegou para: ${rota.settings.name}'),
///   aoVoltar: (rota, anterior) => print('Voltou de: ${rota.settings.name}'),
///   aoAnalytics: (nome, params) => analytics.logScreen(nome, params),
/// );
///
/// GoRouter(
///   observers: [observer],
///   // ...
/// );
/// ```
class ObserverNavegacao extends NavigatorObserver {
  /// Callback chamado quando uma nova rota é empilhada.
  final CallbackNavegacao? aoNavegar;

  /// Callback chamado quando uma rota é removida (pop).
  final CallbackNavegacao? aoVoltar;

  /// Callback chamado quando uma rota é substituída.
  final CallbackNavegacao? aoSubstituir;

  /// Callback chamado quando uma rota é removida sem pop.
  final CallbackNavegacao? aoRemover;

  /// Callback para envio de analytics.
  final CallbackAnalytics? aoAnalytics;

  /// Se deve logar eventos no console (apenas em debug).
  final bool habilitarLogs;

  /// Prefixo para os logs.
  final String prefixoLog;

  ObserverNavegacao({
    this.aoNavegar,
    this.aoVoltar,
    this.aoSubstituir,
    this.aoRemover,
    this.aoAnalytics,
    this.habilitarLogs = true,
    this.prefixoLog = '[RouterCore]',
  });

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('PUSH', route);
    aoNavegar?.call(route, previousRoute);
    _enviarAnalytics(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('POP', route);
    aoVoltar?.call(route, previousRoute);
    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null) {
      _log('REPLACE', newRoute, rotaAnterior: oldRoute);
      aoSubstituir?.call(newRoute, oldRoute);
      _enviarAnalytics(newRoute);
    }
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('REMOVE', route);
    aoRemover?.call(route, previousRoute);
    super.didRemove(route, previousRoute);
  }

  void _log(String acao, Route<dynamic> rota, {Route<dynamic>? rotaAnterior}) {
    if (!habilitarLogs || !kDebugMode) return;

    final nome = rota.settings.name ?? 'sem-nome';
    final buffer = StringBuffer('$prefixoLog $acao: $nome');

    if (rotaAnterior != null) {
      buffer.write(' (anterior: ${rotaAnterior.settings.name ?? 'sem-nome'})');
    }

    debugPrint(buffer.toString());
  }

  void _enviarAnalytics(Route<dynamic> rota) {
    if (aoAnalytics == null) return;

    final nome = rota.settings.name ?? 'desconhecido';
    final args = rota.settings.arguments;

    final params = <String, dynamic>{};
    if (args is Map<String, dynamic>) {
      params.addAll(args);
    } else if (args != null) {
      params['arguments'] = args.toString();
    }

    aoAnalytics!(nome, params);
  }
}

/// Observer simples que apenas loga navegações.
class ObserverLogNavegacao extends ObserverNavegacao {
  ObserverLogNavegacao({super.prefixoLog = '[Nav]'})
    : super(habilitarLogs: true);
}

/// Extensão para criar observers com sintaxe fluente.
extension ObserverNavegacaoBuilder on ObserverNavegacao {
  /// Adiciona callback de analytics.
  ObserverNavegacao comAnalytics(CallbackAnalytics callback) {
    return ObserverNavegacao(
      aoNavegar: aoNavegar,
      aoVoltar: aoVoltar,
      aoSubstituir: aoSubstituir,
      aoRemover: aoRemover,
      aoAnalytics: callback,
      habilitarLogs: habilitarLogs,
      prefixoLog: prefixoLog,
    );
  }

  /// Desabilita logs de debug.
  ObserverNavegacao semLogs() {
    return ObserverNavegacao(
      aoNavegar: aoNavegar,
      aoVoltar: aoVoltar,
      aoSubstituir: aoSubstituir,
      aoRemover: aoRemover,
      aoAnalytics: aoAnalytics,
      habilitarLogs: false,
      prefixoLog: prefixoLog,
    );
  }
}
