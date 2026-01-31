# Router Core

Pacote Flutter para navegação robusta usando `go_router` com `flutter_riverpod`.

## ✨ Features

| Feature | Descrição |
|---------|-----------|
| **Rotas Tipadas** | Navegação type-safe com verificação em compile-time |
| **Guards de Rota** | Sistema de middlewares para proteção de rotas |
| **Serviço de Navegação** | Abstração testável e desacoplada |
| **Exit Confirmation** | Confirmação antes de sair de páginas |
| **Observer** | Analytics e logging de navegação |
| **Extensões Context** | API fluente via BuildContext |

---

## 🚀 Quick Start

### Instalação

```yaml
dependencies:
  router_core:
    path: packages/router_core
```

### Setup Básico

```dart
import 'package:router_core/router_core.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

// Definir rotas tipadas
class RotaHome extends RotaTipada<SemParametros> {
  const RotaHome();
  @override String get nome => 'home';
  @override String get caminho => '/';
  @override String construirCaminho([SemParametros? p]) => caminho;
}

class RotaUsuario extends RotaTipada<ParametrosUsuario> {
  const RotaUsuario();
  @override String get nome => 'usuario';
  @override String get caminho => '/usuario/:id';
  @override String construirCaminho([ParametrosUsuario? p]) => '/usuario/${p?.id}';
}

// Registro central
abstract class RotasApp extends RegistroRotas {
  static const home = RotaHome();
  static const usuario = RotaUsuario();
}

// Configurar router
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RotasApp.home.caminho,
    routes: [
      RotasApp.home.paraGoRoute(
        construtor: (ctx, state, params) => const PaginaHome(),
      ),
      RotasApp.usuario.paraGoRoute(
        construtor: (ctx, state, params) => PaginaUsuario(id: params!.id),
      ),
    ],
  );
});
```

---

## 📖 Guia de Uso

### 1. Navegação via Extensões (Recomendado)

```dart
// Navegar (go - substitui rota)
await context.navegarPara(RotasApp.home);
await context.navegarPara(RotasApp.usuario, params: ParametrosUsuario(id: '123'));

// Push (adiciona à stack)
await context.pushPara(RotasApp.usuario, params: ParametrosUsuario(id: '456'));

// Voltar
await context.voltar();
```

### 2. Guards de Rota

```dart
class GuardAutenticacao extends GuardRota {
  final Ref ref;
  GuardAutenticacao(this.ref);

  @override
  String get nome => 'autenticacao';

  @override
  Future<ResultadoGuard> podeAtivar(ContextoGuard contexto) async {
    final usuario = ref.read(usuarioProvider);
    return usuario != null 
        ? const GuardPermitir() 
        : const GuardRedirecionar('/login');
  }

  @override
  Set<String> get rotasProtegidas => {'/dashboard', '/perfil'};
}

// Registrar guard
ref.read(servicoNavegacaoProvider).adicionarGuard(GuardAutenticacao(ref));
```

### 3. Exit Confirmation

```dart
class PaginaEdicao extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Habilitar confirmação
    enableExitConfirmation(
      ref,
      title: 'Descartar alterações?',
      content: 'As mudanças não salvas serão perdidas.',
    );

    return Scaffold(
      body: ElevatedButton(
        onPressed: () async {
          // Navegação segura mostra diálogo
          await context.navegarPara(RotasApp.home);
        },
        child: const Text('Voltar'),
      ),
    );
  }
}
```

### 4. Observer para Analytics

```dart
final observer = ObserverNavegacao(
  aoNavegar: (rota, _) => print('Navegou: ${rota.settings.name}'),
  aoAnalytics: (nome, params) {
    FirebaseAnalytics.instance.logScreenView(screenName: nome);
  },
);

GoRouter(
  observers: [observer],
  routes: [...],
);
```

---

## 📁 Estrutura do Pacote

```
lib/
├── router_core.dart                    # Exports
└── src/
    ├── rotas/                          # 🆕 Rotas tipadas
    │   ├── rota_configuracao.dart      # RotaTipada, ParametrosRota
    │   └── rota_builder.dart           # Integração GoRouter
    ├── guards/                         # 🆕 Sistema de guards
    │   └── guard_rota.dart             # GuardRota, ResultadoGuard
    ├── navegacao/                      # 🆕 Serviço de navegação
    │   ├── servico_navegacao.dart      # ServicoNavegacao
    │   └── observer_navegacao.dart     # ObserverNavegacao
    ├── extensoes/                      # 🆕 Extensões context
    │   └── navegacao_context_ext.dart
    ├── providers/
    │   ├── router_provider.dart
    │   └── navigation_provider.dart
    ├── widgets/
    │   └── exit_confirmation_widgets.dart
    └── wrappers/
        └── navigation_wrapper.dart
```

---

## 🔧 API Reference

### Rotas Tipadas

| Classe | Uso |
|--------|-----|
| `RotaTipada<T>` | Classe base para rotas |
| `ParametrosRota` | Classe base para parâmetros |
| `SemParametros` | Rotas sem parâmetros |
| `RegistroRotas` | Registro central de rotas |

### Guards

| Classe/Resultado | Descrição |
|------------------|-----------|
| `GuardRota` | Interface para guards |
| `GuardPermitir` | Permite navegação |
| `GuardNegar` | Bloqueia navegação |
| `GuardRedirecionar` | Redireciona para outra rota |
| `GuardCondicional` | Guard inline por condição |

### Serviço de Navegação

| Método | Descrição |
|--------|-----------|
| `navegarPara()` | Go com rota tipada |
| `pushPara()` | Push com rota tipada |
| `voltar()` | Pop |
| `adicionarGuard()` | Registra guard |

### Extensões Context

| Método | Equivalente |
|--------|-------------|
| `context.navegarPara()` | `go` tipado |
| `context.pushPara()` | `push` tipado |
| `context.voltar()` | `pop` |
| `context.podeVoltar` | `canPop` |

---

## 📄 Licença

Veja o arquivo LICENSE para detalhes.
