/// Builders de Rotas para integração com GoRouter
///
/// Fornece utilitários para converter rotas tipadas em
/// configurações do GoRouter.
library;

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'rota_configuracao.dart';

/// Tipo de função para construir widgets de página.
typedef ConstrutorPagina<T extends ParametrosRota> =
    Widget Function(BuildContext contexto, GoRouterState estado, T? parametros);

/// Configuração de uma rota para o GoRouter com tipo-safety.
///
/// Encapsula uma [RotaTipada] com seu builder de página.
///
/// Exemplo:
/// ```dart
/// final rotaUsuario = ConfiguracaoGoRoute(
///   rota: RotaUsuario(),
///   construtor: (contexto, estado, params) {
///     return PaginaUsuario(idUsuario: params?.idUsuario ?? '');
///   },
/// );
/// ```
class ConfiguracaoGoRoute<T extends ParametrosRota> {
  /// A rota tipada associada.
  final RotaTipada<T> rota;

  /// Construtor da página.
  final ConstrutorPagina<T> construtor;

  /// Rotas filhas aninhadas.
  final List<RouteBase> rotasFilhas;

  /// Redirect específico desta rota.
  final String? Function(BuildContext, GoRouterState)? redirect;

  const ConfiguracaoGoRoute({
    required this.rota,
    required this.construtor,
    this.rotasFilhas = const [],
    this.redirect,
  });

  /// Converte esta configuração em um [GoRoute].
  GoRoute paraGoRoute() {
    return GoRoute(
      name: rota.nome,
      path: rota.caminho,
      redirect: redirect,
      routes: rotasFilhas,
      builder: (contexto, estado) {
        final parametros = rota.extrairParametros(estado.pathParameters);
        return construtor(contexto, estado, parametros);
      },
    );
  }
}

/// Extension para facilitar a criação de GoRoutes a partir de rotas tipadas.
extension RotaTipadaExt<T extends ParametrosRota> on RotaTipada<T> {
  /// Cria um [GoRoute] a partir desta rota tipada.
  ///
  /// Exemplo:
  /// ```dart
  /// final routes = [
  ///   RotasApp.home.paraGoRoute(
  ///     construtor: (ctx, state, params) => PaginaHome(),
  ///   ),
  ///   RotasApp.usuario.paraGoRoute(
  ///     construtor: (ctx, state, params) => PaginaUsuario(id: params!.idUsuario),
  ///   ),
  /// ];
  /// ```
  GoRoute paraGoRoute({
    required ConstrutorPagina<T> construtor,
    List<RouteBase> rotasFilhas = const [],
    String? Function(BuildContext, GoRouterState)? redirect,
  }) {
    return GoRoute(
      name: nome,
      path: caminho,
      redirect: redirect,
      routes: rotasFilhas,
      builder: (contexto, estado) {
        final parametros = extrairParametros(estado.pathParameters);
        return construtor(contexto, estado, parametros);
      },
    );
  }
}

/// Helper para criar uma lista de GoRoutes a partir de configurações tipadas.
///
/// Exemplo:
/// ```dart
/// final routes = construirRotas([
///   ConfiguracaoGoRoute(
///     rota: RotasApp.home,
///     construtor: (ctx, state, params) => PaginaHome(),
///   ),
///   ConfiguracaoGoRoute(
///     rota: RotasApp.dashboard,
///     construtor: (ctx, state, params) => PaginaDashboard(),
///   ),
/// ]);
/// ```
List<GoRoute> construirRotas(List<ConfiguracaoGoRoute> configuracoes) {
  return configuracoes.map((config) => config.paraGoRoute()).toList();
}
