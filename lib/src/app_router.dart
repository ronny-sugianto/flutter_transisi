import 'package:flutter/material.dart';
import 'package:flutter_transisi/src/src.dart';
import 'package:go_router/go_router.dart';

GoRouter createAppRouter(AuthenticationDataCubit authDataCubit) {
  return GoRouter(
    refreshListenable: _CubitListenable(authDataCubit),
    redirect: (BuildContext context, GoRouterState state) {
      final isAuthenticated = authDataCubit.state is AuthenticatedState;
      final isLoginRoute = state.matchedLocation == '/login';

      if (!isAuthenticated && !isLoginRoute) return '/login';
      if (isAuthenticated && isLoginRoute) return '/';
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'detail',
            builder: (BuildContext context, GoRouterState state) {
              return const EmployeeDetailScreen();
            },
          ),
          GoRoute(
            path: 'edit',
            builder: (BuildContext context, GoRouterState state) {
              return const EmployeeEditScreen();
            },
          ),
          GoRoute(
            path: 'add',
            builder: (BuildContext context, GoRouterState state) {
              return const EmployeeAddScreen();
            },
          ),
        ],
      ),
    ],
  );
}

/// Adapts a Cubit to a [Listenable] so GoRouter can refresh on state changes.
class _CubitListenable extends ChangeNotifier {
  _CubitListenable(this._cubit) {
    _cubit.stream.listen((_) => notifyListeners());
  }

  final AuthenticationDataCubit _cubit;
}
