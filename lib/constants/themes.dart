import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Theme config for FlexColorScheme version 7.3.x. Make sure you use
// same or higher package version, but still same major version. If you
// use a lower package version, some properties may not be supported.
// In that case remove them after copying this theme to your app.

final lightTheme = FlexThemeData.light(
  scheme: FlexScheme.blue,
  usedColors: 7,
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 7,
  lightIsWhite: true,
  surfaceTint: const Color(0xffffffff),
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 10,
    blendOnColors: false,
    blendTextTheme: true,
    useTextTheme: true,
    useM2StyleDividerInM3: true,
    filledButtonRadius: 5.0,
    elevatedButtonRadius: 5.0,
    outlinedButtonRadius: 5.0,
    inputDecoratorIsFilled: false,
    inputDecoratorBorderSchemeColor: SchemeColor.tertiary,
    cardRadius: 20.0,
    alignedDropdown: true,
    useInputDecoratorThemeInDialogs: true,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
  // To use the Playground font, add GoogleFonts package and uncomment
  fontFamily: GoogleFonts.nunito().fontFamily,
);

final darkTheme = FlexThemeData.dark(
  scheme: FlexScheme.blue,
  usedColors: 7,
  surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
  blendLevel: 13,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 20,
    useTextTheme: true,
    useM2StyleDividerInM3: true,
    filledButtonRadius: 5.0,
    elevatedButtonRadius: 5.0,
    outlinedButtonRadius: 5.0,
    inputDecoratorIsFilled: false,
    cardRadius: 20.0,
    alignedDropdown: true,
    useInputDecoratorThemeInDialogs: true,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  swapLegacyOnMaterial3: true,
  // To use the Playground font, add GoogleFonts package and uncomment
  fontFamily: GoogleFonts.nunito().fontFamily,
);
