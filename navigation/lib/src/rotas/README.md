# Type-Safe Route System

Sistema de rotas tipadas para eliminar strings mágicas e adicionar verificação em compile-time.

## Visão Geral

O problema com navegação tradicional em Flutter/GoRouter:

```dart
// ❌ Propenso a erros - strings mágicas
context.goNamed('usuario', pathParameters: {'idUsuario': '123'});
context.goNamed('usario'); // Typo! Runtime error!
```

Com rotas tipadas:

```dart
// ✅ Type-safe - verificação em compile-time
context.navegarPara(RotasApp.usuario, params: ParametrosUsuario(idUsuario: '123'));
RotasApp.usario // ❌ Erro de compilação!
```

## Componentes

### 1. ParametrosRota

Classe base para parâmetros de rota:

```dart
class ParametrosUsuario extends ParametrosRota {
  final String idUsuario;
  final String? aba;

  const ParametrosUsuario({
    required this.idUsuario,
    this.aba,
  });

  @override
  Map<String, String> paraPathParams() => {'idUsuario': idUsuario};

  @override
  Map<String, dynamic> paraQueryParams() =>
      aba != null ? {'aba': aba} : {};
}
```

### 2. RotaTipada

Define uma rota com tipo genérico para parâmetros:

```dart
class RotaUsuario extends RotaTipada<ParametrosUsuario> {
  const RotaUsuario();

  @override
  String get nome => 'usuario';

  @override
  String get caminho => '/usuario/:idUsuario';

  @override
  String construirCaminho([ParametrosUsuario? params]) {
    if (params == null) return caminho;
    return '/usuario/${params.idUsuario}';
  }

  @override
  ParametrosUsuario? extrairParametros(Map<String, String> pathParams) {
    final id = pathParams['idUsuario'];
    if (id == null) return null;
    return ParametrosUsuario(idUsuario: id);
  }
}
```

### 3. RegistroRotas

Agrupa todas as rotas em um único lugar:

```dart
abstract class RotasApp extends RegistroRotas {
  static const home = RotaHome();
  static const dashboard = RotaDashboard();
  static const usuario = RotaUsuario();
  static const configuracoes = RotaConfiguracoes();
}
```

### 4. Integração com GoRouter

Use a extension para converter rotas tipadas:

```dart
final goRouter = GoRouter(
  initialLocation: RotasApp.home.caminho,
  routes: [
    RotasApp.home.paraGoRoute(
      construtor: (ctx, state, params) => const PaginaHome(),
    ),
    RotasApp.usuario.paraGoRoute(
      construtor: (ctx, state, params) => PaginaUsuario(
        idUsuario: params!.idUsuario,
      ),
    ),
  ],
);
```

## Rotas Sem Parâmetros

Use `SemParametros` para rotas simples:

```dart
class RotaHome extends RotaTipada<SemParametros> {
  const RotaHome();

  @override
  String get nome => 'home';

  @override
  String get caminho => '/';

  @override
  String construirCaminho([SemParametros? params]) => caminho;
}
```

## Metadata de Rota

Adicione informações extras com o mixin:

```dart
class RotaDashboard extends RotaTipada<SemParametros> with MetadataRota {
  const RotaDashboard();

  @override
  String get nome => 'dashboard';

  @override
  String get caminho => '/dashboard';

  @override
  String construirCaminho([SemParametros? params]) => caminho;

  // Metadata
  @override
  String get titulo => 'Painel';

  @override
  IconData get icone => Icons.dashboard;

  @override
  bool get requerAutenticacao => true;
}
```

## Benefícios

| Aspecto | Antes | Depois |
|---------|-------|--------|
| **Typos** | Runtime error | Compile-time error |
| **Autocomplete** | ❌ Nenhum | ✅ IDE sugere rotas |
| **Refactoring** | Manual em todo projeto | Automático pelo IDE |
| **Documentação** | Strings espalhadas | Classes documentadas |
| **Parâmetros** | Map<String, String> | Objetos tipados |
