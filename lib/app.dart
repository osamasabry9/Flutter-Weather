import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/themes/app_theme.dart';
import 'core/utils/app_strings.dart';
import 'presentation/bloc/weather_cubit.dart';
import 'presentation/screens/loading_screen.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherAppCubit()..getCitiesFromJson()..getLocation(),
      child: MaterialApp(
        title: AppStrings.appName,
        themeMode: ThemeMode.system,
        theme: AppThemes.appTheme(isLight: true),
        darkTheme: AppThemes.appTheme(isLight: false),
        debugShowCheckedModeBanner: false,
        home: LoadingScreen(),
      ),
    );
  }
}
