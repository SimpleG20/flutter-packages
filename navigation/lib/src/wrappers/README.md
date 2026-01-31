# Wrappers

Este diretório contém funções wrapper de navegação que fornecem capacidades de navegação segura e não-segura.

## Arquivos

- `navigation_wrapper.dart` - Funções de navegação segura e não-segura

## navigation_wrapper.dart

Provê funções wrapper de navegação que verificam confirmação de saída antes de navegar (segura) ou ignoram verificações de confirmação (não-segura).

## Funções de Navegação Segura

Funções de navegação segura verificam se a confirmação de saída é obrigatória antes de navegar. Se obrigatória, mostram um diálogo de confirmação. A navegação só prossegue se o usuário confirmar ou se a confirmação não for necessária.

### `safeGo()`
Wrapper para `context.go()` que verifica confirmação de saída.

```dart
Future<bool> safeGo({
  required BuildContext context,
  required WidgetRef ref,
  required String location,
  Object? extra,
})
```

**Retorna:** `true` se a navegação ocorreu, `false` se cancelada ou contexto não está montado.

**Exemplo:**
```dart
await safeGo(
  context: context,
  ref: ref,
  location: '/dashboard',
);
```

### `safeGoNamed()`
Wrapper para `context.goNamed()` que verifica confirmação de saída.

```dart
await safeGoNamed(
  context: context,
  ref: ref,
  name: 'dashboard',
  pathParameters: {'id': '123'},
);
```

### `safePush()`
Wrapper para `context.push()` que verifica confirmação de saída.

### `safePushNamed()`
Wrapper para `context.pushNamed()` que verifica confirmação de saída.

### `safePop()`
Wrapper para `context.pop()` que verifica confirmação de saída.

## Funções de Navegação Não-Segura

Funções de navegação não-segura ignoram verificações de confirmação e navegam imediatamente. Use quando tiver certeza de que a navegação deve prosseguir sem confirmação (ex: após salvar alterações, no logout, etc.).

### `unsafeGo()`
Navega SEM verificação de confirmação.

```dart
unsafeGo(
  context: context,
  location: '/dashboard',
);
```

### `unsafeGoNamed()`
Navega para rota nomeada SEM verificação.

### `unsafePush()`
Push SEM verificação de confirmação.

### `unsafePushNamed()`
Push de rota nomeada SEM verificação.

### `unsafePop()`
Pop SEM verificação de confirmação.

## Quando Usar Cada Tipo

### Navegação Segura
- Usuário pode ter alterações não salvas
- Navegação deve respeitar configurações de confirmação
- Quer comportamento consistente no app

### Navegação Não-Segura
- Alterações foram salvas
- Usuário confirmou explicitamente uma ação
- Está fazendo logout ou resetando estado

## Push vs Go

### `go` / `goNamed` (Navegação por Substituição)
- **Substitui** a rota atual na stack de navegação
- Usuário **não pode** voltar à rota anterior usando botão voltar
- Use para: Login → Dashboard, Formulário → Sucesso

### `push` / `pushNamed` (Navegação por Stack)
- **Adiciona** nova rota no topo da atual
- Usuário **pode** voltar à rota anterior usando botão voltar
- Use para: Dashboard → Configurações, Lista → Detalhes

## API Preferida

> **Recomendação:** Para nova código, prefira usar as extensões de contexto em `navegacao_context_ext.dart` ou o `ServicoNavegacao` para uma API mais moderna e type-safe.

```dart
// API Moderna (Recomendada)
await context.navegarPara(RotasApp.dashboard);
await context.pushPara(RotasApp.usuario, params: ParametrosUsuario(id: '123'));

// API Legacy (Ainda Suportada)
await safeGoNamed(context: context, ref: ref, name: 'dashboard');
```

## Documentação Relacionada

- [README Principal](../../README.md) - Visão geral do pacote
- [Documentação de Providers](../providers/README.md) - Gerenciamento de estado
- [Documentação de Widgets](../widgets/README.md) - Componentes de widget
