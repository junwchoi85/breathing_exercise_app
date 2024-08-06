import 'package:breathing_exercise_app/src/features/breathing/presentation/bloc/breathing_bloc.dart';
import 'package:breathing_exercise_app/src/features/breathing/presentation/pages/home_page.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeMode themeMode = ThemeMode.system;
  bool useMaterial3 = true;

  @override
  Widget build(BuildContext context) {
    const FlexScheme usedScheme = FlexScheme.greenM3;

    return BlocProvider(
      create: (context) => BreathingBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Breathing Exercise App',
        theme: FlexThemeData.light(
          scheme: usedScheme,
          appBarElevation: 0.5,
          useMaterial3: useMaterial3,
          typography: Typography.material2021(
            platform: defaultTargetPlatform,
          ),
        ),
        darkTheme: FlexThemeData.dark(
          scheme: usedScheme,
          appBarElevation: 2,
          useMaterial3: useMaterial3,
          typography: Typography.material2021(
            platform: defaultTargetPlatform,
          ),
        ),
        themeMode: themeMode,
        home: HomePage(),
      ),
    );
  }
}
