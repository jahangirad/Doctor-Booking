import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final isLoading = false.obs;
  final String adminEmail = 'jahangirad14@gmail.com';
  final supabase = Supabase.instance.client;

  Future<void> signUpNewUser(
      String name,
      String email,
      String password,
      String phone,
      ) async {
    try {
      isLoading.value = true;

      final result = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (result.user != null) {
        await supabase.from('users').insert({
          'uid': result.user!.id,
          'name': name,
          'email': email,
          'phone': phone,
        });

        Get.snackbar(
          'Signup Successful',
          'User registered and saved to database.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        if (email == adminEmail) {
          Get.offAllNamed('/adminpanel-screen');
        } else {
          Get.offAllNamed('/main-screen');
        }
      } else {
        throw Exception('Signup failed: No user returned');
      }

    } catch (e) {
      Get.snackbar(
        'Signup Failed',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    try {
      isLoading.value = true;
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      Get.snackbar(
        'Login Successful',
        'Successfully logged in.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      if (email == adminEmail) {
        Get.offAllNamed('/adminpanel-screen');
      } else {
        Get.offAllNamed('/main-screen');
      }
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        'Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logoutUser() async {
    try {
      await supabase.auth.signOut();
      Get.snackbar(
        'Logout Successfully',
        'See you again',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAllNamed('/login-screen');
    } catch (e) {
      Get.snackbar(
        'Logout Failed',
        'Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      isLoading.value = true;
      await supabase.auth.resetPasswordForEmail(
        email.trim(),
        redirectTo: 'doctorbooking://resetpassword-screen',
      );
      Get.snackbar(
        'Success',
        'Password reset link has been sent to your email.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    diplinkConfig(Get.context!);
  }

  void diplinkConfig(BuildContext context) {
    final applinks = AppLinks();

    applinks.uriLinkStream.listen((uri) {
      if (uri.scheme == 'doctorbooking' && uri.host == 'resetpassword-screen') {
        print('✅ Deep link detected: $uri');
      } else {
        print('❌ Unsupported deep link: $uri');
      }
    }, onError: (err) {
      print('❌ Error in deep link handling: $err');
    });
  }

  Future<void> updatePassword(String newPassword) async {
    try {
      isLoading.value = true;
      final response = await supabase.auth.updateUser(
        UserAttributes(password: newPassword.trim()),
      );

      if (response.user != null) {
        Get.snackbar(
          'Success',
          'Password updated successfully.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      } else {
        throw Exception('Failed to update password');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changePasswordSecurely(String currentPassword, String newPassword) async {
    try {
      final user = supabase.auth.currentUser;

      if (user == null || user.email == null) {
        throw Exception('User not logged in');
      }

      // Step 1: Verify current password
      await supabase.auth.signInWithPassword(
        email: user.email!,
        password: currentPassword,
      );

      // Step 2: Update password
      final response = await supabase.auth.updateUser(
        UserAttributes(password: newPassword.trim()),
      );

      if (response.user != null) {
        Get.snackbar('Success', 'Password changed successfully.');
      } else {
        throw Exception('Failed to update password.');
      }

    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
