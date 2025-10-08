import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';
import 'colors.dart'; // Se importa la nueva paleta de colores

class ShrineApp extends StatelessWidget {
  const ShrineApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shrine',
      home: const HomeScreen(),
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
      theme: _buildShrineTheme(), // Se aplica el nuevo tema
    );
  }

  Route<dynamic>? _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => const LoginScreen(),
      fullscreenDialog: true,
    );
  }
}

// Función para construir el tema de Shrine
ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light(useMaterial3: true);
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: kShrinePink100,
      onPrimary: kShrineBrown900,
      secondary: kShrineBrown900,
      error: kShrineErrorRed,
    ),
    scaffoldBackgroundColor: kShrineBackgroundWhite,
    textTheme: _buildShrineTextTheme(base.textTheme),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: kShrinePink100,
    ),
    appBarTheme: const AppBarTheme(
      foregroundColor: kShrineBrown900,
      backgroundColor: kShrinePink100,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: kShrinePink400,
          width: 1.0,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2.0,
          color: kShrineBrown900,
        ),
      ),
      floatingLabelStyle: TextStyle(
        color: kShrineBrown900,
      ),
    ),
  );
}

// Función para construir la tipografía de Shrine
TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        headlineSmall: base.headlineSmall!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        titleLarge: base.titleLarge!.copyWith(
          fontSize: 18.0,
        ),
        bodySmall: base.bodySmall!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        bodyLarge: base.bodyLarge!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(
        displayColor: kShrineBrown900,
        bodyColor: kShrineBrown900,
      );
}
