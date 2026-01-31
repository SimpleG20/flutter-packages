# Changelog

All notable changes to this project will be documented in this file.

## [0.0.1] - 2026-01-30

### Added
- Initial release
- `AppNotification` entity with immutable design
- `NotificationRepository` abstract interface
- `NotificationDatasource` abstract interface
- `NotificationRepositoryImpl` default implementation
- `FirebaseNotificationDatasource` for FCM support
- Riverpod providers: `notificationRepositoryProvider`, `notificationStreamProvider`, `notificationTokenProvider`, `notificationInitProvider`
- Sealed exception hierarchy for type-safe error handling
- Topic subscription/unsubscription support
