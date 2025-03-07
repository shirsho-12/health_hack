import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/force_update/force_update_view.dart';
import '../features/initial_screen/initial_screen_view_controller.dart';

abstract class AppRouter {
  List<RouteBase> get routes;
}

class MobileRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static const String landingScreenRoute = '/landing';
  static const String forceUpdateRoute = '/force_update';

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: landingScreenRoute,
    routes: <RouteBase>[
      GoRoute(
        path: landingScreenRoute,
        name: landingScreenRoute,
        builder: (_, __) => const InitialScreenViewController(),
      ),
      GoRoute(
        path: forceUpdateRoute,
        name: forceUpdateRoute,
        builder: (_, state) {
          final isRequiredUpdate = state.extra as bool;
          return ForceUpdateView(isRequiredUpdate: isRequiredUpdate);
        },
      ),
    ],
  );

  static void redirectToForceUpdate({required bool isRequiredVersion}) {
    final context = MobileRouter.rootNavigatorKey.currentContext;
    if (context == null) return;

    context.goNamed(forceUpdateRoute);
  }
}
