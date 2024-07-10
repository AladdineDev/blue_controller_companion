import 'package:blue_controller_companion/router/router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:blue_controller_companion/constants/themes.dart' as themes;

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(routerProvider),
      theme: themes.lightTheme,
      darkTheme: themes.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
