import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthController authController = Get.put(AuthController());
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          'Sign Up',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
            fontSize: 24.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 30.h),
                CustomTextField(hintText: 'Full Name', controller: name),
                SizedBox(height: 16.h),
                CustomTextField(hintText: 'Email', controller: email),
                SizedBox(height: 16.h),
                CustomTextField(hintText: 'Phone Number', controller: phone),
                SizedBox(height: 16.h),
                CustomTextField(hintText: 'Password', isPassword: true, controller: password),
                SizedBox(height: 16.h),
                CustomTextField(hintText: 'Confirm Password', isPassword: true, controller: confirmPassword),
                SizedBox(height: 30.h),
                CustomButton(
                  text: 'Create Account',
                  onPressed: authController.isLoading.value ? null : () {
                    if (password.text.trim() != confirmPassword.text.trim()) {
                      Get.snackbar(
                        'Error',
                        'Password and Confirm Password not mass!',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }
                    authController.signUpNewUser(name.text.trim(), email.text.trim(), password.text.trim(), phone.text.trim());
                    name.clear();
                    email.clear();
                    password.clear();
                    confirmPassword.clear();
                    phone.clear();
                  }
                ),
                SizedBox(height: 100.h),
                _buildSignInLink(),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInLink() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 14.sp,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          children: [
            const TextSpan(text: 'Already have an account? '),
            TextSpan(
              text: 'Sign In',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
