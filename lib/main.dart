import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'core/theme/app_theme.dart';
import 'views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Get the saved theme mode
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return AdaptiveTheme(
          light: AppTheme.lightTheme,
          dark: AppTheme.darkTheme,
          initial: savedThemeMode ?? AdaptiveThemeMode.system,
          builder: (theme, darkTheme) {
            return GetMaterialApp(
              title: 'Admin Panel',
              debugShowCheckedModeBanner: false,
              theme: theme,
              darkTheme: darkTheme,
              home: SplashScreen(),
              // initialRoute: AppPages.routes.last.name,
              // getPages: AppPages.routes,
            );
          },
        );
      },
    );
  }
}
