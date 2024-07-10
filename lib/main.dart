import 'package:blue_controller_companion/features/app_startup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:blue_controller_companion/features/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(
    ProviderScope(
      child: AppStartupWidget(
        onLoaded: (context) => const App(),
      ),
    ),
  );
}
