import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Provider para GoRouter configurado com Riverpod.
///
/// Exemplo de uso:
/// ```dart
/// final routerProvider = Provider<GoRouter>((ref) {
///   return GoRouter(
///     routes: [
///       GoRoute(
///         path: '/',
///         builder: (context, state) => PaginaInicial(),
///       ),
///     ],
///   );
/// });
/// ```
typedef ProviderRoteador = Provider<GoRouter>;

// Alias para compatibilidade
typedef RouterProvider = ProviderRoteador;

/// Fábrica de provider para criar um ProviderRoteador.
///
/// Use este helper para criar um provider de roteador:
/// ```dart
/// final routerProvider = criarProviderRoteador(
///   rotas: [
///     GoRoute(
///       path: '/',
///       builder: (context, state) => PaginaInicial(),
///     ),
///   ],
/// );
/// ```
Provider<GoRouter> criarProviderRoteador({
  required List<RouteBase> rotas,
  String? localizacaoInicial,
  GoRouterRedirect? redirecionar,
  int limiteRedirecionamentos = 5,
  GoExceptionHandler? aoExcecao,
  String? idEscopoRestauracao,
  bool logDiagnosticosDebug = false,
}) {
  return Provider<GoRouter>((ref) {
    return GoRouter(
      routes: rotas,
      initialLocation: localizacaoInicial,
      redirect: redirecionar,
      redirectLimit: limiteRedirecionamentos,
      onException: aoExcecao,
      restorationScopeId: idEscopoRestauracao,
      debugLogDiagnostics: logDiagnosticosDebug,
    );
  });
}

// Alias para compatibilidade
Provider<GoRouter> createRouterProvider({
  required List<RouteBase> routes,
  String? initialLocation,
  GoRouterRedirect? redirect,
  int redirectLimit = 5,
  GoExceptionHandler? onException,
  String? restorationScopeId,
  bool debugLogDiagnostics = false,
}) => criarProviderRoteador(
  rotas: routes,
  localizacaoInicial: initialLocation,
  redirecionar: redirect,
  limiteRedirecionamentos: redirectLimit,
  aoExcecao: onException,
  idEscopoRestauracao: restorationScopeId,
  logDiagnosticosDebug: debugLogDiagnostics,
);
