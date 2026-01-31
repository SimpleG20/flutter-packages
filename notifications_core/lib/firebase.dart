/// Firebase Cloud Messaging implementation for notifications_core.
///
/// Import this file to use Firebase as your notification provider.
///
/// ## Requirements
///
/// Add `firebase_messaging` to your app's pubspec.yaml:
/// ```yaml
/// dependencies:
///   firebase_messaging: ^16.0.0
/// ```
///
/// ## Usage
///
/// ```dart
/// import 'package:notifications_core/notifications_core.dart';
/// import 'package:notifications_core/firebase.dart';
///
/// void main() {
///   WidgetsFlutterBinding.ensureInitialized();
///   await Firebase.initializeApp();
///
///   // Register background handler
///   FirebaseMessaging.onBackgroundMessage(firebaseBackgroundMessageHandler);
///
///   runApp(
///     ProviderScope(
///       overrides: [
///         notificationRepositoryProvider.overrideWithValue(
///           NotificationRepositoryImpl(
///             FirebaseNotificationDatasource.instance(),
///           ),
///         ),
///       ],
///       child: MyApp(),
///     ),
///   );
/// }
/// ```
library;

export 'src/data/datasources/firebase_notification_datasource.dart';
