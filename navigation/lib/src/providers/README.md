# Providers

Este diretório contém providers Riverpod para configuração do roteador e gerenciamento de estado de confirmação de saída.

## Arquivos

- `router_provider.dart` - Utilitários de configuração do roteador
- `navigation_provider.dart` - Gerenciamento de estado de confirmação de saída

## router_provider.dart

Provê utilitários para criar um provider GoRouter com Riverpod.

### Exports

#### `ProviderRoteador` / `RouterProvider`

Alias de tipo para `Provider<GoRouter>`.

#### `criarProviderRoteador()` / `createRouterProvider()`

Função fábrica para criar um provider de roteador com opções de configuração.

```dart
Provider<GoRouter> criarProviderRoteador({
  required List<RouteBase> rotas,
  String? localizacaoInicial,
  GoRouterRedirect? redirecionar,
  int limiteRedirecionamentos = 5,
  GoExceptionHandler? aoExcecao,
  String? idEscopoRestauracao,
  bool logDiagnosticosDebug = false,
})
```

**Exemplo:**

```dart
final routerProvider = criarProviderRoteador(
  rotas: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const PaginaInicial(),
    ),
  ],
  localizacaoInicial: '/',
  redirecionar: (context, state) {
    // Sua lógica de middleware
    return null;
  },
);
```

## navigation_provider.dart

Gerencia estado de confirmação de saída usando Riverpod.

### Exports

#### `ConfiguracaoConfirmacaoSaida` / `ExitConfirmationConfig`

Classe de configuração para diálogos de confirmação de saída.

**Propriedades:**

- `obrigatorio` (bool): Se a confirmação é obrigatória
- `titulo` (String): Título do diálogo
- `conteudo` (String): Conteúdo do diálogo
- `textoConfirmar` (String): Texto do botão confirmar
- `textoCancelar` (String): Texto do botão cancelar

**Valores Padrão:**

- `titulo`: "Sair desta página?"
- `conteudo`: "Tem certeza de que deseja sair?"
- `textoConfirmar`: "Sair"
- `textoCancelar`: "Cancelar"

#### `confirmacaoSaidaProvider` / `exitConfirmationProvider`

StateProvider que mantém a configuração atual de confirmação de saída.

```dart
// Verificar se confirmação é obrigatória
final config = ref.watch(confirmacaoSaidaProvider);
if (config.obrigatorio) {
  // Mostrar diálogo de confirmação
}
```

#### `habilitarConfirmacaoSaida()` / `enableExitConfirmation()`

Helper para habilitar confirmação de saída com mensagens personalizadas.

```dart
// Habilitar com mensagens padrão
habilitarConfirmacaoSaida(ref);

// Habilitar com mensagens personalizadas
habilitarConfirmacaoSaida(
  ref,
  titulo: 'Descartar alterações?',
  conteudo: 'Você tem alterações não salvas.',
  textoConfirmar: 'Descartar',
  textoCancelar: 'Continuar Editando',
);
```

#### `desabilitarConfirmacaoSaida()` / `disableExitConfirmation()`

Helper para desabilitar confirmação de saída.

```dart
void _salvarAlteracoes() {
  // Lógica de salvamento...
  
  // Desabilitar confirmação de saída
  desabilitarConfirmacaoSaida(ref);
  
  // Navegar
  context.go('/dashboard');
}
```

## Documentação Relacionada

- [README Principal](../../README.md) - Visão geral do pacote
- [Documentação de Widgets](../widgets/README.md) - Componentes de widget
- [Documentação de Wrappers](../wrappers/README.md) - Wrappers de navegação
