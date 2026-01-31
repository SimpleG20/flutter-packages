/// Core notification package with multi-provider support.
///
/// This package provides a provider-agnostic notification system
/// with Riverpod integration.
///
/// ## Basic Usage
///
/// 1. Add the package to your pubspec.yaml
/// 2. Override [notificationRepositoryProvider] with your implementation
/// 3. Use [notificationStreamProvider] to listen for notifications
///
/// See [firebase.dart] for Firebase implementation.
library;

// Domain - Entities
export 'src/domain/entities/app_notification.dart';

// Domain - Repositories
export 'src/domain/repositories/notification_repository.dart';

// Domain - Exceptions
export 'src/domain/exceptions/notification_exception.dart';

// Data - Datasources
export 'src/data/datasources/notification_datasource.dart';

// Data - Repositories
export 'src/data/repositories/notification_repository_impl.dart';

// Presentation - Providers
export 'src/presentation/providers/notification_providers.dart';
