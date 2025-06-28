import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:doctor_booking/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'controllers/auth_controller.dart';
import 'core/routes/app_pages.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Get the saved theme mode
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  await dotenv.load(fileName: ".env");
  Stripe.publishableKey = '${dotenv.env['publishable_key']}';
  await Stripe.instance.applySettings();
  await Supabase.initialize(
    url: dotenv.env['supabaseUrl']!, //your supabase url
    anonKey: dotenv.env['supabaseKey']!, //your supabase key
  );
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    AuthController().diplinkConfig(context);
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
              title: 'Doctor Booking',
              debugShowCheckedModeBanner: false,
              defaultTransition: Transition.fade,
              transitionDuration: Duration(milliseconds: 300),
              theme: theme,
              darkTheme: darkTheme,
              initialRoute: AppRoutes.splashscreen,
              getPages: AppPages.routes,
            );
          },
        );
      },
    );
  }
}
