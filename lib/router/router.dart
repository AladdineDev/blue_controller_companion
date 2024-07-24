import 'package:blue_controller_companion/features/controller/presentation/controller_configuration_upload_screen.dart';
import 'package:blue_controller_companion/features/auth/presentation/sign_up_screen.dart';
import 'package:blue_controller_companion/features/controller/presentation/controller_list_screen.dart';
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
    initialLocation: '/controller-configuration-upload',
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

@TypedGoRoute<SignUpScreenRoute>(
  path: '/sign-up',
)
@immutable
class SignUpScreenRoute extends GoRouteData {
  const SignUpScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignUpScreen();
  }
}

@TypedGoRoute<ControllerConfigurationScreenRoute>(
  path: '/controller-configuration/:controllerConfigurationId',
)
@immutable
class ControllerConfigurationScreenRoute extends GoRouteData {
  const ControllerConfigurationScreenRoute({
    required this.controllerConfigurationId,
  });

  final String controllerConfigurationId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ControllerConfigurationScreen(
      controllerConfigurationId: controllerConfigurationId,
    );
  }
}

@TypedGoRoute<ControllerConfigurationListScreenRoute>(
  path: '/controller-configuration-list',
)
@immutable
class ControllerConfigurationListScreenRoute extends GoRouteData {
  const ControllerConfigurationListScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ControllerConfigurationListScreen();
  }
}

@TypedGoRoute<ControllerConfigurationUploadScreenRoute>(
  path: '/controller-configuration-upload',
)
@immutable
class ControllerConfigurationUploadScreenRoute extends GoRouteData {
  const ControllerConfigurationUploadScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ControllerConfigurationUploadScreen();
  }
}
