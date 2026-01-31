import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Configuração para confirmação de saída em uma página.
class ConfiguracaoConfirmacaoSaida {
  /// Se a confirmação de saída é obrigatória.
  final bool obrigatorio;

  /// Título do diálogo de confirmação.
  final String titulo;

  /// Conteúdo do diálogo de confirmação.
  final String conteudo;

  /// Texto do botão de confirmação.
  final String textoConfirmar;

  /// Texto do botão de cancelamento.
  final String textoCancelar;

  const ConfiguracaoConfirmacaoSaida({
    this.obrigatorio = false,
    this.titulo = 'Sair desta página?',
    this.conteudo = 'Tem certeza de que deseja sair?',
    this.textoConfirmar = 'Sair',
    this.textoCancelar = 'Cancelar',
  });

  ConfiguracaoConfirmacaoSaida copiarCom({
    bool? obrigatorio,
    String? titulo,
    String? conteudo,
    String? textoConfirmar,
    String? textoCancelar,
  }) {
    return ConfiguracaoConfirmacaoSaida(
      obrigatorio: obrigatorio ?? this.obrigatorio,
      titulo: titulo ?? this.titulo,
      conteudo: conteudo ?? this.conteudo,
      textoConfirmar: textoConfirmar ?? this.textoConfirmar,
      textoCancelar: textoCancelar ?? this.textoCancelar,
    );
  }
}

// Alias para manter compatibilidade com código existente
typedef ExitConfirmationConfig = ConfiguracaoConfirmacaoSaida;

/// Notifier para gerenciar o estado de confirmação de saída.
///
/// Substitui o antigo StateProvider no Riverpod 3.x.
class ConfirmacaoSaidaNotifier extends Notifier<ConfiguracaoConfirmacaoSaida> {
  @override
  ConfiguracaoConfirmacaoSaida build() =>
      const ConfiguracaoConfirmacaoSaida(obrigatorio: false);

  /// Expõe o setter para permitir atualização do state.
  @override
  set state(ConfiguracaoConfirmacaoSaida newState) => super.state = newState;

  /// Define a configuração de confirmação de saída.
  void definir(ConfiguracaoConfirmacaoSaida config) {
    state = config;
  }

  /// Habilita a confirmação de saída com mensagens personalizadas.
  void habilitar({
    String? titulo,
    String? conteudo,
    String? textoConfirmar,
    String? textoCancelar,
  }) {
    const configPadrao = ConfiguracaoConfirmacaoSaida();
    state = ConfiguracaoConfirmacaoSaida(
      obrigatorio: true,
      titulo: (titulo?.isEmpty ?? true) ? configPadrao.titulo : titulo!,
      conteudo: (conteudo?.isEmpty ?? true) ? configPadrao.conteudo : conteudo!,
      textoConfirmar: (textoConfirmar?.isEmpty ?? true)
          ? configPadrao.textoConfirmar
          : textoConfirmar!,
      textoCancelar: (textoCancelar?.isEmpty ?? true)
          ? configPadrao.textoCancelar
          : textoCancelar!,
    );
  }

  /// Desabilita a confirmação de saída, mantendo os textos configurados.
  void desabilitar() {
    state = ConfiguracaoConfirmacaoSaida(
      obrigatorio: false,
      titulo: state.titulo,
      conteudo: state.conteudo,
      textoConfirmar: state.textoConfirmar,
      textoCancelar: state.textoCancelar,
    );
  }
}

/// Provider para gerenciar a configuração de confirmação de saída.
///
/// Use para configurar a confirmação de saída para a tela atual.
/// Quando o usuário tentar navegar, os wrappers de navegação verificarão
/// esta configuração e mostrarão um diálogo de confirmação se necessário.
final confirmacaoSaidaProvider =
    NotifierProvider<ConfirmacaoSaidaNotifier, ConfiguracaoConfirmacaoSaida>(
      ConfirmacaoSaidaNotifier.new,
    );

// Alias para manter compatibilidade
final exitConfirmationProvider = confirmacaoSaidaProvider;

/// Verifica se a confirmação de saída é obrigatória.
bool confirmacaoSaidaObrigatoria(WidgetRef ref) {
  return ref.read(confirmacaoSaidaProvider).obrigatorio;
}

// Alias
bool isExitConfirmationRequired(WidgetRef ref) =>
    confirmacaoSaidaObrigatoria(ref);

/// Define a configuração de confirmação de saída.
void definirConfirmacaoSaida(
  WidgetRef ref,
  ConfiguracaoConfirmacaoSaida config,
) {
  ref.read(confirmacaoSaidaProvider.notifier).definir(config);
}

// Alias
void setExitConfirmation(WidgetRef ref, ExitConfirmationConfig config) =>
    definirConfirmacaoSaida(ref, config);

/// Habilita a confirmação de saída com mensagens personalizadas.
///
/// Sempre usa valores padrão. Se um parâmetro for null ou string vazia,
/// o valor padrão de ConfiguracaoConfirmacaoSaida será usado.
/// Apenas valores não vazios substituirão os padrões.
void habilitarConfirmacaoSaida(
  WidgetRef ref, {
  String? titulo,
  String? conteudo,
  String? textoConfirmar,
  String? textoCancelar,
}) {
  ref
      .read(confirmacaoSaidaProvider.notifier)
      .habilitar(
        titulo: titulo,
        conteudo: conteudo,
        textoConfirmar: textoConfirmar,
        textoCancelar: textoCancelar,
      );
}

// Alias para manter compatibilidade
void enableExitConfirmation(
  WidgetRef ref, {
  String? title,
  String? content,
  String? confirmText,
  String? cancelText,
}) => habilitarConfirmacaoSaida(
  ref,
  titulo: title,
  conteudo: content,
  textoConfirmar: confirmText,
  textoCancelar: cancelText,
);

/// Desabilita a confirmação de saída.
void desabilitarConfirmacaoSaida(WidgetRef ref) {
  ref.read(confirmacaoSaidaProvider.notifier).desabilitar();
}

// Alias
void disableExitConfirmation(WidgetRef ref) => desabilitarConfirmacaoSaida(ref);
