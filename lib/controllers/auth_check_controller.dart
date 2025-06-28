import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthCheckController extends GetxController{
  Future<void> redirectUser() async {
    await Future.delayed(Duration.zero);

    // বর্তমান সেশন নিন
    final session = Supabase.instance.client.auth.currentSession;

    if (session == null) {
      // লগইন না থাকলে লগইন স্ক্রিনে পাঠান
      Get.offAllNamed('/login-screen');
    } else {
      // অ্যাডমিন চেক
      const String adminEmail = 'jahangirad14@gmail.com';
      final userEmail = session.user.email ?? '';

      if (userEmail == adminEmail) {
        Get.offAllNamed('/adminpanel-screen');
      } else {
        Get.offAllNamed('/main-screen');
      }
    }
  }
}