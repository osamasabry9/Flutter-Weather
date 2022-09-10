import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import 'widgets/app_bar_theme.dart';
import 'widgets/icon_theme.dart';
import 'widgets/text_theme.dart';


class AppThemes {
  static ThemeData appTheme({required bool isLight}) {
    return ThemeData(
      brightness: isLight ? Brightness.light : Brightness.dark,
      appBarTheme: AppBarThemes.appBarTheme(isLight: isLight),
      scaffoldBackgroundColor: isLight ? AppColors.lightGrey : AppColors.black,
      textTheme: AppTextThemes.textTheme(isLight: isLight),
      iconTheme: AppIconThemes.iconTheme(isLight: isLight),
    );
  }
}
