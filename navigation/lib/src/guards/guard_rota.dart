/// Sistema de Guards para proteção de rotas.
///
/// Guards são middlewares que verificam condições antes de permitir
/// a navegação para uma rota. Exemplos: autenticação, permissões, etc.
library;

import 'package:flutter/foundation.dart';

/// Resultado da verificação de um guard.
///
/// Use as subclasses:
/// - [GuardPermitir] - navegação permitida
/// - [GuardNegar] - navegação bloqueada
/// - [GuardRedirecionar] - redirecionar para outra rota
@immutable
sealed class ResultadoGuard {
  const ResultadoGuard();
}

/// Permite a navegação.
class GuardPermitir extends ResultadoGuard {
  const GuardPermitir();
}

/// Nega a navegação com uma razão opcional.
class GuardNegar extends ResultadoGuard {
  /// Razão pela qual a navegação foi negada.
  final String? razao;

  /// Callback opcional para executar quando negado (ex: mostrar snackbar).
  final void Function()? aoNegar;

  const GuardNegar([this.razao, this.aoNegar]);
}

/// Redireciona para outra rota.
class GuardRedirecionar extends ResultadoGuard {
  /// Caminho para redirecionar.
  final String caminhoRedirecionamento;

  /// Parâmetros extras para o redirecionamento.
  final Object? extra;

  const GuardRedirecionar(this.caminhoRedirecionamento, {this.extra});
}

/// Contexto passado ao guard durante a verificação.
///
/// Contém informações sobre a navegação sendo tentada.
@immutable
class ContextoGuard {
  /// Caminho de destino da navegação.
  final String caminhoDestino;

  /// Caminho atual (antes da navegação).
  final String? caminhoAtual;

  /// Path parameters extraídos da URL.
  final Map<String, String> pathParams;

  /// Query parameters da URL.
  final Map<String, dynamic> queryParams;

  /// Dados extras passados na navegação.
  final Object? extra;

  const ContextoGuard({
    required this.caminhoDestino,
    this.caminhoAtual,
    this.pathParams = const {},
    this.queryParams = const {},
    this.extra,
  });

  @override
  String toString() =>
      'ContextoGuard(destino: $caminhoDestino, atual: $caminhoAtual)';
}

/// Interface base para guards de rota.
///
/// Implemente esta classe para criar guards customizados.
///
/// Exemplo de guard de autenticação:
/// ```dart
/// class GuardAutenticacao extends GuardRota {
///   final ProviderRef ref;
///
///   GuardAutenticacao(this.ref);
///
///   @override
///   String get nome => 'autenticacao';
///
///   @override
///   Future<ResultadoGuard> podeAtivar(ContextoGuard contexto) async {
///     final usuario = ref.read(usuarioProvider);
///     if (usuario == null) {
///       return GuardRedirecionar('/login');
///     }
///     return GuardPermitir();
///   }
///
///   @override
///   Set<String> get rotasProtegidas => {'/dashboard', '/perfil', '/configuracoes'};
/// }
/// ```
abstract class GuardRota {
  const GuardRota();

  /// Nome identificador do guard (para logs e debugging).
  String get nome;

  /// Verifica se a navegação pode prosseguir.
  ///
  /// Retorne:
  /// - [GuardPermitir] para permitir
  /// - [GuardNegar] para bloquear
  /// - [GuardRedirecionar] para redirecionar
  Future<ResultadoGuard> podeAtivar(ContextoGuard contexto);

  /// Conjunto de rotas que este guard protege.
  ///
  /// Se vazio, o guard se aplica a TODAS as rotas.
  /// Se preenchido, aplica-se apenas às rotas listadas.
  Set<String> get rotasProtegidas => const {};

  /// Verifica se este guard se aplica à rota especificada.
  bool aplicaA(String caminho) {
    if (rotasProtegidas.isEmpty) return true;
    return rotasProtegidas.any((rota) => caminho.startsWith(rota));
  }
}

/// Gerenciador de guards para o sistema de navegação.
///
/// Centraliza a execução de múltiplos guards.
class GerenciadorGuards {
  final List<GuardRota> _guards = [];

  /// Adiciona um guard ao gerenciador.
  void adicionar(GuardRota guard) {
    if (!_guards.contains(guard)) {
      _guards.add(guard);
    }
  }

  /// Remove um guard do gerenciador.
  void remover(GuardRota guard) {
    _guards.remove(guard);
  }

  /// Remove todos os guards.
  void limpar() {
    _guards.clear();
  }

  /// Lista de guards registrados (somente leitura).
  List<GuardRota> get guards => List.unmodifiable(_guards);

  /// Executa todos os guards aplicáveis para o contexto.
  ///
  /// Retorna o primeiro resultado que não seja [GuardPermitir],
  /// ou [GuardPermitir] se todos os guards permitirem.
  Future<ResultadoGuard> executar(ContextoGuard contexto) async {
    for (final guard in _guards) {
      if (!guard.aplicaA(contexto.caminhoDestino)) continue;

      final resultado = await guard.podeAtivar(contexto);

      if (resultado is! GuardPermitir) {
        debugPrint(
          '[Guards] ${guard.nome} bloqueou navegação para '
          '${contexto.caminhoDestino}: $resultado',
        );
        return resultado;
      }
    }

    return const GuardPermitir();
  }
}

/// Guard composto que combina múltiplos guards com lógica AND.
///
/// Todos os guards devem permitir para a navegação prosseguir.
class GuardComposto extends GuardRota {
  final List<GuardRota> _guards;

  const GuardComposto(this._guards);

  @override
  String get nome => 'composto(${_guards.map((g) => g.nome).join(', ')})';

  @override
  Future<ResultadoGuard> podeAtivar(ContextoGuard contexto) async {
    for (final guard in _guards) {
      final resultado = await guard.podeAtivar(contexto);
      if (resultado is! GuardPermitir) {
        return resultado;
      }
    }
    return const GuardPermitir();
  }
}

/// Guard que verifica uma condição simples.
///
/// Útil para guards inline sem criar uma classe.
///
/// Exemplo:
/// ```dart
/// GuardCondicional(
///   nome: 'maioridade',
///   condicao: () async => usuario.idade >= 18,
///   aoFalhar: GuardRedirecionar('/acesso-negado'),
/// );
/// ```
class GuardCondicional extends GuardRota {
  @override
  final String nome;

  /// Função que retorna a condição a ser verificada.
  final Future<bool> Function(ContextoGuard contexto) condicao;

  /// Resultado a retornar se a condição falhar.
  final ResultadoGuard aoFalhar;

  /// Rotas protegidas por este guard.
  @override
  final Set<String> rotasProtegidas;

  const GuardCondicional({
    required this.nome,
    required this.condicao,
    this.aoFalhar = const GuardNegar('Condição não satisfeita'),
    this.rotasProtegidas = const {},
  });

  @override
  Future<ResultadoGuard> podeAtivar(ContextoGuard contexto) async {
    final permitido = await condicao(contexto);
    return permitido ? const GuardPermitir() : aoFalhar;
  }
}
