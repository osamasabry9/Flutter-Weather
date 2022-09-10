import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../system/system_overlay_style.dart';

class AppBarThemes {
  static AppBarTheme appBarTheme({required bool isLight}) {
    return AppBarTheme(
      systemOverlayStyle:
          AppSystemUiOverlayStyle.setSystemUiOverlayStyle(isLight: isLight),
      backgroundColor: AppColors.darkGrey,
      elevation: 0,
    );
  }
}
