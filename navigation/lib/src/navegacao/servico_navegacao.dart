/// Serviço de Navegação centralizado.
///
/// Provê uma abstração sobre o GoRouter com suporte a:
/// - Rotas tipadas
/// - Guards de rota
/// - Confirmação de saída
/// - Logging/Analytics
library;

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../guards/guard_rota.dart';
import '../providers/navigation_provider.dart';
import '../rotas/rota_configuracao.dart';
import '../wrappers/navigation_wrapper.dart' as wrappers;

/// Provider global do serviço de navegação.
final servicoNavegacaoProvider = Provider<ServicoNavegacao>((ref) {
  return ServicoNavegacaoImpl(ref);
});

/// Interface do serviço de navegação.
///
/// Use esta interface para navegação em toda a aplicação.
/// Pode ser facilmente mockada para testes.
abstract class ServicoNavegacao {
  /// Gerenciador de guards registrados.
  GerenciadorGuards get guards;

  /// Navega para uma rota tipada (substitui a rota atual).
  ///
  /// Retorna `true` se a navegação foi bem-sucedida.
  Future<bool> navegarPara<T extends ParametrosRota>(
    BuildContext contexto,
    RotaTipada<T> rota, {
    T? params,
    Object? extra,
    bool verificarConfirmacao = true,
  });

  /// Push de uma rota tipada (adiciona à stack).
  ///
  /// Retorna `true` se a navegação foi bem-sucedida.
  Future<bool> pushPara<T extends ParametrosRota>(
    BuildContext contexto,
    RotaTipada<T> rota, {
    T? params,
    Object? extra,
    bool verificarConfirmacao = true,
  });

  /// Navega para um caminho string (legacy/fallback).
  Future<bool> irPara(
    BuildContext contexto,
    String caminho, {
    Object? extra,
    bool verificarConfirmacao = true,
  });

  /// Push para um caminho string (legacy/fallback).
  Future<bool> pushCaminho(
    BuildContext contexto,
    String caminho, {
    Object? extra,
    bool verificarConfirmacao = true,
  });

  /// Volta para a rota anterior.
  Future<bool> voltar(BuildContext contexto, {dynamic resultado});

  /// Verifica se pode voltar.
  bool podeVoltar(BuildContext contexto);

  /// Adiciona um guard ao sistema.
  void adicionarGuard(GuardRota guard);

  /// Remove um guard do sistema.
  void removerGuard(GuardRota guard);

  /// Obtém o serviço a partir do contexto.
  static ServicoNavegacao of(BuildContext contexto) {
    return ProviderScope.containerOf(
      contexto,
      listen: false,
    ).read(servicoNavegacaoProvider);
  }
}

/// Implementação padrão do serviço de navegação.
class ServicoNavegacaoImpl implements ServicoNavegacao {
  final Ref _ref;

  @override
  final GerenciadorGuards guards = GerenciadorGuards();

  ServicoNavegacaoImpl(this._ref);

  @override
  Future<bool> navegarPara<T extends ParametrosRota>(
    BuildContext contexto,
    RotaTipada<T> rota, {
    T? params,
    Object? extra,
    bool verificarConfirmacao = true,
  }) async {
    if (!contexto.mounted) return false;
    final caminho = rota.construirCaminho(params);

    // Executar guards
    final resultadoGuard = await _executarGuards(contexto, caminho, extra);
    if (!contexto.mounted) return false;
    if (resultadoGuard != null) {
      return _tratarResultadoGuard(contexto, resultadoGuard);
    }

    // Navegar
    return _navegarComConfirmacao(
      contexto: contexto,
      caminho: caminho,
      extra: extra,
      verificarConfirmacao: verificarConfirmacao,
      usarPush: false,
    );
  }

  @override
  Future<bool> pushPara<T extends ParametrosRota>(
    BuildContext contexto,
    RotaTipada<T> rota, {
    T? params,
    Object? extra,
    bool verificarConfirmacao = true,
  }) async {
    if (!contexto.mounted) return false;
    final caminho = rota.construirCaminho(params);

    // Executar guards
    final resultadoGuard = await _executarGuards(contexto, caminho, extra);
    if (!contexto.mounted) return false;
    if (resultadoGuard != null) {
      return _tratarResultadoGuard(contexto, resultadoGuard);
    }

    // Push
    return _navegarComConfirmacao(
      contexto: contexto,
      caminho: caminho,
      extra: extra,
      verificarConfirmacao: verificarConfirmacao,
      usarPush: true,
    );
  }

  @override
  Future<bool> irPara(
    BuildContext contexto,
    String caminho, {
    Object? extra,
    bool verificarConfirmacao = true,
  }) async {
    if (!contexto.mounted) return false;

    // Executar guards
    final resultadoGuard = await _executarGuards(contexto, caminho, extra);
    if (!contexto.mounted) return false;
    if (resultadoGuard != null) {
      return _tratarResultadoGuard(contexto, resultadoGuard);
    }

    return _navegarComConfirmacao(
      contexto: contexto,
      caminho: caminho,
      extra: extra,
      verificarConfirmacao: verificarConfirmacao,
      usarPush: false,
    );
  }

  @override
  Future<bool> pushCaminho(
    BuildContext contexto,
    String caminho, {
    Object? extra,
    bool verificarConfirmacao = true,
  }) async {
    if (!contexto.mounted) return false;

    // Executar guards
    final resultadoGuard = await _executarGuards(contexto, caminho, extra);
    if (!contexto.mounted) return false;
    if (resultadoGuard != null) {
      return _tratarResultadoGuard(contexto, resultadoGuard);
    }

    return _navegarComConfirmacao(
      contexto: contexto,
      caminho: caminho,
      extra: extra,
      verificarConfirmacao: verificarConfirmacao,
      usarPush: true,
    );
  }

  @override
  Future<bool> voltar(BuildContext contexto, {dynamic resultado}) async {
    try {
      final container = ProviderScope.containerOf(contexto, listen: false);
      // Criar um WidgetRef mock-like usando o container
      return _voltarComConfirmacao(contexto, container);
    } catch (e) {
      if (contexto.mounted) {
        contexto.pop(resultado);
        return true;
      }
      return false;
    }
  }

  @override
  bool podeVoltar(BuildContext contexto) {
    return wrappers.canPop(context: contexto);
  }

  @override
  void adicionarGuard(GuardRota guard) {
    guards.adicionar(guard);
  }

  @override
  void removerGuard(GuardRota guard) {
    guards.remover(guard);
  }

  // --- Métodos Privados ---

  Future<ResultadoGuard?> _executarGuards(
    BuildContext contexto,
    String caminho,
    Object? extra,
  ) async {
    if (guards.guards.isEmpty) return null;

    final contextoGuard = ContextoGuard(
      caminhoDestino: caminho,
      caminhoAtual: _obterCaminhoAtual(contexto),
      extra: extra,
    );

    final resultado = await guards.executar(contextoGuard);
    if (resultado is GuardPermitir) return null;
    return resultado;
  }

  String? _obterCaminhoAtual(BuildContext contexto) {
    try {
      return GoRouterState.of(contexto).uri.toString();
    } catch (_) {
      return null;
    }
  }

  Future<bool> _tratarResultadoGuard(
    BuildContext contexto,
    ResultadoGuard resultado,
  ) async {
    switch (resultado) {
      case GuardPermitir():
        return true;

      case GuardNegar(:final aoNegar):
        aoNegar?.call();
        return false;

      case GuardRedirecionar(:final caminhoRedirecionamento, :final extra):
        if (contexto.mounted) {
          contexto.go(caminhoRedirecionamento, extra: extra);
        }
        return true;
    }
  }

  Future<bool> _navegarComConfirmacao({
    required BuildContext contexto,
    required String caminho,
    required Object? extra,
    required bool verificarConfirmacao,
    required bool usarPush,
  }) async {
    if (!contexto.mounted) return false;

    if (!verificarConfirmacao) {
      if (usarPush) {
        await contexto.push(caminho, extra: extra);
      } else {
        contexto.go(caminho, extra: extra);
      }
      return true;
    }

    // Verificar confirmação de saída
    final config = _ref.read(confirmacaoSaidaProvider);
    if (!config.obrigatorio) {
      if (usarPush) {
        await contexto.push(caminho, extra: extra);
      } else {
        contexto.go(caminho, extra: extra);
      }
      return true;
    }

    // Usar o wrapper existente para confirmação
    if (usarPush) {
      return wrappers.unsafePush(
        context: contexto,
        location: caminho,
        extra: extra,
      );
    } else {
      return wrappers.unsafeGo(
        context: contexto,
        location: caminho,
        extra: extra,
      );
    }
  }

  Future<bool> _voltarComConfirmacao(
    BuildContext contexto,
    ProviderContainer container,
  ) async {
    if (!contexto.mounted) return false;

    final config = container.read(confirmacaoSaidaProvider);
    if (!config.obrigatorio) {
      contexto.pop();
      return true;
    }

    return wrappers.unsafePop(context: contexto);
  }
}
