import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    primaryColor: AppColors.lightButton,
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      background: AppColors.lightBackground,//Background Color
      primary: AppColors.lightTextField,//TextField Color
      onPrimary: AppColors.lightTextFieldLabel,//TextField Label Color
      secondary: AppColors.lightText,//Ui Text Color
      onSecondary: AppColors.lightButton,//Button Color
      surface: AppColors.lightCheckBox,//CheckBox Color
      onSurface: AppColors.lightNavigateText,//Navigate Text Color
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    primaryColor: AppColors.darkButton,
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      background: AppColors.darkBackground,//Background Color
      primary: AppColors.darkTextField,//TextField Color
      onPrimary: AppColors.darkTextFieldLabel,//TextField Label Color
      secondary: AppColors.darkText,//Ui Text Color
      onSecondary: AppColors.darkButton,//Button Color
      surface: AppColors.darkCheckBox,//CheckBox Color
      onSurface: AppColors.darkNavigateText,//Navigate Text Color
    ),
  );
}