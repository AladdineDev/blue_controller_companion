import 'package:blue_controller_companion/features/controller/presentation/controller_screen.dart';
import 'package:blue_controller_companion/features/auth/presentation/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
    routes: $appRoutes,
    initialLocation: '/login',
    // redirect: (context, state) async {
    // TODO: Implement redirect
    //   final authRepository = ref.watch(authRepositoryProvider);
    //   if (state.path == "/login") {
    //     try {
    //       await authRepository.reSignIn();
    //       return "/controllers";
    //     } on LoginSessionExpired catch (_) {
    //       return "/login";
    //     }
    //   }
    //   return state.path;
    // },
  );
}

@TypedGoRoute<LoginScreenRoute>(
  path: '/login',
)
@immutable
class LoginScreenRoute extends GoRouteData {
  const LoginScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginScreen();
  }
}

@TypedGoRoute<ControllerScreenRoute>(
  path: '/controller',
)
@immutable
class ControllerScreenRoute extends GoRouteData {
  const ControllerScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ControllerScreen();
  }
}
