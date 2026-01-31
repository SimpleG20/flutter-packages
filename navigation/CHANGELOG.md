# Changelog

All notable changes to this project will be documented in this file.

## [0.2.0] - 2026-01-29

### Added

#### Type-Safe Routes
- `RotaTipada<T>` - Base class for typed routes
- `ParametrosRota` - Base class for route parameters
- `SemParametros` - For routes without parameters
- `RegistroRotas` - Central route registry
- `rota_builder.dart` - GoRouter integration utilities

#### Route Guards System
- `GuardRota` - Interface for route guards
- `ResultadoGuard` - Sealed class for guard results
  - `GuardPermitir` - Allow navigation
  - `GuardNegar` - Deny navigation
  - `GuardRedirecionar` - Redirect to another route
- `GerenciadorGuards` - Guard manager
- `GuardCondicional` - Inline conditional guard
- `GuardComposto` - Combine multiple guards

#### Navigation Service
- `ServicoNavegacao` - Navigation abstraction interface
- `ServicoNavegacaoImpl` - Default implementation
- `servicoNavegacaoProvider` - Riverpod provider

#### Context Extensions
- `context.navegarPara()` - Type-safe go
- `context.pushPara()` - Type-safe push
- `context.voltar()` - Pop
- `context.podeVoltar` - Can pop check

#### Navigation Observer
- `ObserverNavegacao` - Analytics/logging observer
- `ObserverLogNavegacao` - Simple logging observer

### Changed

- **BREAKING**: Refactored `navigation_wrapper.dart` (524 → 346 lines)
- Centralized navigation logic with generic `_navegarComConfirmacao`
- Updated exports in `router_core.dart`

### Deprecated

- Legacy wrapper functions (`safeGo`, `safeGoNamed`, etc.) - Use context extensions instead

## [0.1.0] - 2026-01-20

### Added

- Initial release
- GoRouter + Riverpod integration
- Exit confirmation system
- Safe/Unsafe navigation wrappers
