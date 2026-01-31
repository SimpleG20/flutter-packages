/// Extensões do BuildContext para navegação fluente.
///
/// Provê uma API limpa e conveniente para navegação diretamente
/// através do contexto, sem precisar obter o serviço manualmente.
library;

import 'package:flutter/widgets.dart';

import '../navegacao/servico_navegacao.dart';
import '../rotas/rota_configuracao.dart';

/// Extensões de navegação para [BuildContext].
///
/// Uso:
/// ```dart
/// // Navegar para rota tipada
/// context.navegarPara(RotasApp.dashboard);
/// context.navegarPara(RotasApp.usuario, params: ParametrosUsuario(id: '123'));
///
/// // Push para rota tipada
/// context.pushPara(RotasApp.detalhes, params: ParametrosDetalhes(itemId: '456'));
///
/// // Voltar
/// context.voltar();
/// ```
extension NavegacaoContextExt on BuildContext {
  /// Obtém o serviço de navegação.
  ServicoNavegacao get navegacao => ServicoNavegacao.of(this);

  /// Navega para uma rota tipada (substitui a rota atual).
  ///
  /// Exemplo:
  /// ```dart
  /// await context.navegarPara(RotasApp.dashboard);
  /// await context.navegarPara(
  ///   RotasApp.usuario,
  ///   params: ParametrosUsuario(idUsuario: '123'),
  /// );
  /// ```
  Future<bool> navegarPara<T extends ParametrosRota>(
    RotaTipada<T> rota, {
    T? params,
    Object? extra,
    bool verificarConfirmacao = true,
  }) {
    return navegacao.navegarPara(
      this,
      rota,
      params: params,
      extra: extra,
      verificarConfirmacao: verificarConfirmacao,
    );
  }

  /// Push de uma rota tipada (adiciona à stack de navegação).
  ///
  /// Exemplo:
  /// ```dart
  /// await context.pushPara(RotasApp.detalhes);
  /// await context.pushPara(
  ///   RotasApp.editor,
  ///   params: ParametrosEditor(documentoId: '789'),
  /// );
  /// ```
  Future<bool> pushPara<T extends ParametrosRota>(
    RotaTipada<T> rota, {
    T? params,
    Object? extra,
    bool verificarConfirmacao = true,
  }) {
    return navegacao.pushPara(
      this,
      rota,
      params: params,
      extra: extra,
      verificarConfirmacao: verificarConfirmacao,
    );
  }

  /// Navega para um caminho string (uso legado/fallback).
  ///
  /// Prefira usar [navegarPara] com rotas tipadas.
  Future<bool> irParaCaminho(
    String caminho, {
    Object? extra,
    bool verificarConfirmacao = true,
  }) {
    return navegacao.irPara(
      this,
      caminho,
      extra: extra,
      verificarConfirmacao: verificarConfirmacao,
    );
  }

  /// Push para um caminho string (uso legado/fallback).
  ///
  /// Prefira usar [pushPara] com rotas tipadas.
  Future<bool> pushCaminho(
    String caminho, {
    Object? extra,
    bool verificarConfirmacao = true,
  }) {
    return navegacao.pushCaminho(
      this,
      caminho,
      extra: extra,
      verificarConfirmacao: verificarConfirmacao,
    );
  }

  /// Volta para a rota anterior.
  ///
  /// Exemplo:
  /// ```dart
  /// await context.voltar();
  /// await context.voltar(resultado: 'sucesso');
  Future<bool> voltar({dynamic resultado}) {
    return navegacao.voltar(this, resultado: resultado);
  }

  /// Verifica se pode voltar para uma rota anterior.
  bool get podeVoltar => navegacao.podeVoltar(this);
}