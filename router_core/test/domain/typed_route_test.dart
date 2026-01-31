import 'package:flutter_test/flutter_test.dart';
import 'package:router_core/router_core.dart';

// Test route params
class UserParams extends RouteParams {
  final String userId;
  final String? tab;

  const UserParams({required this.userId, this.tab});

  @override
  Map<String, String> toPathParams() => {'userId': userId};

  @override
  Map<String, dynamic> toQueryParams() => tab != null ? {'tab': tab} : {};
}

// Test routes
class HomeRoute extends AppRoute<NoParams> {
  const HomeRoute();

  @override
  String get name => 'home';

  @override
  String get path => '/';

  @override
  String buildPath([NoParams? params]) => path;
}

class UserRoute extends AppRoute<UserParams> {
  const UserRoute();

  @override
  String get name => 'user';

  @override
  String get path => '/user/:userId';

  @override
  String buildPath([UserParams? params]) {
    if (params == null) return path;
    var result = '/user/${params.userId}';
    final query = params.toQueryParams();
    if (query.isNotEmpty) {
      result += '?${query.entries.map((e) => '${e.key}=${e.value}').join('&')}';
    }
    return result;
  }

  @override
  UserParams? extractParams(Map<String, String> pathParams) {
    final userId = pathParams['userId'];
    if (userId == null) return null;
    return UserParams(userId: userId);
  }
}

class SettingsRoute extends AppRoute<NoParams> with RouteMetadata<NoParams> {
  const SettingsRoute();

  @override
  String get name => 'settings';

  @override
  String get path => '/settings';

  @override
  String buildPath([NoParams? params]) => path;

  @override
  String? get title => 'Settings';

  @override
  bool get showInNavigation => true;

  @override
  int get navigationOrder => 1;
}

abstract class TestRoutes with RouteRegistry {
  static const home = HomeRoute();
  static const user = UserRoute();
  static const settings = SettingsRoute();
}

void main() {
  group('RouteParams', () {
    test('NoParams should return empty maps', () {
      const params = NoParams();
      expect(params.toPathParams(), isEmpty);
      expect(params.toQueryParams(), isEmpty);
    });

    test('UserParams should return correct path params', () {
      const params = UserParams(userId: '123');
      expect(params.toPathParams(), {'userId': '123'});
      expect(params.toQueryParams(), isEmpty);
    });

    test('UserParams should return correct query params when tab is set', () {
      const params = UserParams(userId: '123', tab: 'profile');
      expect(params.toPathParams(), {'userId': '123'});
      expect(params.toQueryParams(), {'tab': 'profile'});
    });
  });

  group('AppRoute', () {
    test('HomeRoute should have correct name and path', () {
      const route = HomeRoute();
      expect(route.name, 'home');
      expect(route.path, '/');
    });

    test('UserRoute should have correct name and path', () {
      const route = UserRoute();
      expect(route.name, 'user');
      expect(route.path, '/user/:userId');
    });

    test('buildPath should return path pattern when params is null', () {
      const route = UserRoute();
      expect(route.buildPath(), '/user/:userId');
    });

    test('buildPath should substitute params correctly', () {
      const route = UserRoute();
      const params = UserParams(userId: '123');
      expect(route.buildPath(params), '/user/123');
    });

    test('buildPath should include query params', () {
      const route = UserRoute();
      const params = UserParams(userId: '123', tab: 'profile');
      expect(route.buildPath(params), '/user/123?tab=profile');
    });

    test('extractParams should return typed params', () {
      const route = UserRoute();
      final params = route.extractParams({'userId': '456'});
      expect(params, isNotNull);
      expect(params!.userId, '456');
    });

    test('extractParams should return null for missing required params', () {
      const route = UserRoute();
      final params = route.extractParams({});
      expect(params, isNull);
    });

    test('routes should be equal by name', () {
      const route1 = HomeRoute();
      const route2 = HomeRoute();
      expect(route1, equals(route2));
    });

    test('requiresAuth should default to false', () {
      const route = HomeRoute();
      expect(route.requiresAuth, isFalse);
    });
  });

  group('RouteMetadata', () {
    test('should provide title', () {
      const route = SettingsRoute();
      expect(route.title, 'Settings');
    });

    test('should provide showInNavigation', () {
      const route = SettingsRoute();
      expect(route.showInNavigation, isTrue);
    });

    test('should provide navigationOrder', () {
      const route = SettingsRoute();
      expect(route.navigationOrder, 1);
    });
  });

  group('RouteRegistry', () {
    test('should provide access to typed route constants', () {
      expect(TestRoutes.home.name, 'home');
      expect(TestRoutes.user.name, 'user');
      expect(TestRoutes.settings.name, 'settings');
    });
  });
}
