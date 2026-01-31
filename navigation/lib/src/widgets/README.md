# Widgets

Este diretório contém componentes de widget para funcionalidade de confirmação de saída.

## Arquivos

- `exit_confirmation_widgets.dart` - Widgets de confirmação de saída

## exit_confirmation_widgets.dart

Provê widgets que envolvem conteúdo e interceptam eventos de navegação para mostrar diálogos de confirmação de saída.

### Exports

#### `ConfirmacaoSaida` / `ExitConfirmation`

Widget que envolve seu app e fornece confirmação de saída interceptando eventos de navegação (como botão voltar no Android) e mostrando um diálogo de confirmação antes de permitir a saída.

**Construtor:**

```dart
const ConfirmacaoSaida({
  super.key,
  required this.filho,
  this.aoConfirmarSaida,
  this.titulo = 'Sair do aplicativo?',
  this.conteudo = 'Tem certeza de que deseja sair?',
  this.textoConfirmar = 'Sair',
  this.textoCancelar = 'Cancelar',
  this.estiloBotaoConfirmar,
  this.estiloBotaoCancelar,
})
```

**Parâmetros:**

- `filho` (obrigatório): O widget a ser envolvido
- `aoConfirmarSaida`: Callback opcional chamado quando o usuário confirma. Retorna `true` para permitir saída, `false` para cancelar
- `titulo`: Título do diálogo (padrão: "Sair do aplicativo?")
- `conteudo`: Conteúdo do diálogo (padrão: "Tem certeza de que deseja sair?")
- `textoConfirmar`: Texto do botão confirmar (padrão: "Sair")
- `textoCancelar`: Texto do botão cancelar (padrão: "Cancelar")
- `estiloBotaoConfirmar`: Estilo opcional do botão confirmar
- `estiloBotaoCancelar`: Estilo opcional do botão cancelar

**Comportamento:**

- Usa `PopScope` para interceptar pressionamentos do botão voltar
- Mostra um `AlertDialog` quando usuário tenta sair
- Se `Navigator.of(context).canPop()` retornar `true`, faz pop da rota atual
- Caso contrário, fecha o app (Android: `SystemNavigator.pop()`, iOS: `exit(0)`)

**Exemplo de Uso:**

```dart
import 'package:router_core/router_core.dart';

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return ConfirmacaoSaida(
      titulo: 'Sair do aplicativo?',
      conteudo: 'Tem certeza de que deseja sair?',
      textoConfirmar: 'Sair',
      textoCancelar: 'Cancelar',
      aoConfirmarSaida: () {
        // Opcional: lógica adicional antes de sair
        return true;
      },
      filho: MaterialApp.router(
        routerConfig: router,
        title: 'Meu App',
      ),
    );
  }
}
```

**Nota:** Este widget é primariamente para confirmação de saída no nível do app. Para confirmação por tela durante navegação programática, use `habilitarConfirmacaoSaida()` combinado com wrappers de navegação segura ou extensões de contexto.

## Documentação Relacionada

- [README Principal](../../README.md) - Visão geral do pacote
- [Documentação de Providers](../providers/README.md) - Gerenciamento de estado
- [Documentação de Wrappers](../wrappers/README.md) - Wrappers de navegação
