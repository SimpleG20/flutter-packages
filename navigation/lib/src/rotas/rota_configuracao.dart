/// Configuração de Rotas Tipadas para Router Core
///
/// Este módulo fornece a base para rotas type-safe,
/// eliminando strings mágicas e adicionando verificação em compile-time.
library;

import 'package:flutter/foundation.dart';

/// Classe base abstrata para parâmetros de rota.
///
/// Estenda esta classe para criar parâmetros tipados para suas rotas.
///
/// Exemplo:
/// ```dart
/// class ParametrosUsuario extends ParametrosRota {
///   final String idUsuario;
///   final String? aba;
///
///   const ParametrosUsuario({
///     required this.idUsuario,
///     this.aba,
///   });
///
///   @override
///   Map<String, String> paraPathParams() => {'idUsuario': idUsuario};
///
///   @override
///   Map<String, dynamic> paraQueryParams() =>
///       aba != null ? {'aba': aba} : {};
/// }
/// ```
@immutable
abstract class ParametrosRota {
  const ParametrosRota();

  /// Converte parâmetros para path parameters (usados no path da URL).
  ///
  /// Exemplo: `/usuario/:idUsuario` → `{'idUsuario': '123'}`
  Map<String, String> paraPathParams();

  /// Converte parâmetros para query parameters (usados após `?` na URL).
  ///
  /// Exemplo: `/usuario/123?aba=perfil` → `{'aba': 'perfil'}`
  Map<String, dynamic> paraQueryParams() => const {};
}

/// Classe especial para rotas sem parâmetros.
///
/// Use quando sua rota não precisa de nenhum parâmetro.
class SemParametros extends ParametrosRota {
  const SemParametros();

  @override
  Map<String, String> paraPathParams() => const {};

  @override
  Map<String, dynamic> paraQueryParams() => const {};
}

/// Classe base abstrata para definir rotas tipadas.
///
/// Estenda esta classe para cada rota da sua aplicação.
///
/// Exemplo:
/// ```dart
/// class RotaDashboard extends RotaTipada<SemParametros> {
///   const RotaDashboard();
///
///   @override
///   String get nome => 'dashboard';
///
///   @override
///   String get caminho => '/dashboard';
///
///   @override
///   String construirCaminho([SemParametros? params]) => caminho;
/// }
///
/// class RotaUsuario extends RotaTipada<ParametrosUsuario> {
///   const RotaUsuario();
///
///   @override
///   String get nome => 'usuario';
///
///   @override
///   String get caminho => '/usuario/:idUsuario';
///
///   @override
///   String construirCaminho([ParametrosUsuario? params]) {
///     if (params == null) return caminho;
///     return '/usuario/${params.idUsuario}';
///   }
/// }
/// ```
@immutable
abstract class RotaTipada<T extends ParametrosRota> {
  const RotaTipada();

  /// Nome único da rota para navegação via `goNamed`.
  String get nome;

  /// Padrão do caminho com placeholders.
  ///
  /// Exemplo: `/usuario/:idUsuario`
  String get caminho;

  /// Constrói o caminho final substituindo os parâmetros.
  ///
  /// Se [params] for null, retorna o [caminho] padrão.
  String construirCaminho([T? params]);

  /// Extrai path parameters de um mapa de parâmetros.
  ///
  /// Útil para reconstruir o objeto de parâmetros a partir do GoRouterState.
  T? extrairParametros(Map<String, String> pathParams) => null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RotaTipada &&
          runtimeType == other.runtimeType &&
          nome == other.nome;

  @override
  int get hashCode => nome.hashCode;

  @override
  String toString() => 'RotaTipada(nome: $nome, caminho: $caminho)';
}

/// Registro centralizado de rotas da aplicação.
///
/// Use para agrupar todas as rotas tipadas em um único lugar.
///
/// Exemplo:
/// ```dart
/// class RotasApp extends RegistroRotas {
///   static const home = RotaHome();
///   static const dashboard = RotaDashboard();
///   static const usuario = RotaUsuario();
///   static const configuracoes = RotaConfiguracoes();
/// }
///
/// // Uso:
/// contexto.navegarPara(RotasApp.dashboard);
/// contexto.navegarPara(RotasApp.usuario, params: ParametrosUsuario(idUsuario: '123'));
/// ```
abstract class RegistroRotas {
  const RegistroRotas();
}

/// Mixin para adicionar funcionalidades extras às rotas.
///
/// Útil para adicionar metadata como ícones, títulos, etc.
mixin MetadataRota<T extends ParametrosRota> on RotaTipada<T> {
  /// Título amigável da rota para exibição.
  String? get titulo => null;

  /// Ícone associado à rota.
  dynamic get icone => null;

  /// Se a rota requer autenticação.
  bool get requerAutenticacao => false;

  /// Se a rota deve ser mostrada na navegação.
  bool get mostrarNaNavegacao => true;
}
