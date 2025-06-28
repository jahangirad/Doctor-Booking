import 'package:get/get.dart';

import '../../views/admin_panel_screen.dart';
import '../../views/appointment_confirmed_screen.dart';
import '../../views/book_appointment_screen.dart';
import '../../views/forgot_password_screen.dart';
import '../../views/login_screen.dart';
import '../../views/nav_main_screen.dart';
import '../../views/reset_password_screen.dart';
import '../../views/signup_screen.dart';
import '../../views/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splashscreen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.signupscreen,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: AppRoutes.loginscreen,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.forgotpasswordscreen,
      page: () => ForgotPasswordScreen(),
    ),
    GetPage(
      name: AppRoutes.resetpasswordscreen,
      page: () => ResetPasswordScreen(),
    ),
    GetPage(
      name: AppRoutes.mainscreen,
      page: () => MainScreen(),
    ),
    GetPage(
      name: AppRoutes.adminpanelscreen,
      page: () => AdminPanelScreen(),
    ),
  ];
}
