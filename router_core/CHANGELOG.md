# Changelog

All notable changes to this project will be documented in this file.

## [0.3.1] - 2026-02-16

### Changed
- Refined dependency constraints and environment requirements.

## [0.3.0] - 2026-01-31

### Added
- **Safe Navigation Wrappers**: New `safeGo`, `safeGoNamed`, `safePush`, `safePushNamed` helper functions that integrate with `ExitGuard`.
- **Pop Wrappers**: Added `safePop` (alias for `context.pop`) and `unsafePop` (forces exit without confirmation).
- **Unsafe Navigation Wrappers**: Explicit `unsafe*` variants for bypassing checks.

## [0.2.0] - 2026-01-31

### Added
- **Route Guards System**: Centralized protection for routes with `GuardService` and `RouteGuard`.
- **Typed Routes**: Type-safe route definitions with `AppRoute` and parameter handling.
- **Navigation Service**: Testable `NavigationService` interface and GoRouter implementation.
- **Context Extensions**: Fluent navigation via `context.navigateTo` and `context.pushTo`.
- **Navigation Observer**: `AppNavigationObserver` for tracking and analytics.

## [0.1.0] - 2026-01-31

### Added
- Initial release of router_core with exit guard functionality.
