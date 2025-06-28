import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'forgot_password_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.put(AuthController());
  bool _isPasswordVisible = false;
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          'Login',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                _buildWelcomeHeader(),
                SizedBox(height: 30.h),
                CustomTextField(hintText: 'Email / Phone Number', controller: email,),
                SizedBox(height: 16.h),
                CustomTextField2(
                  controller: password,
                  hintText: 'Password',
                  obscureText: !_isPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                SizedBox(height: 12.h),
                _buildForgotPasswordLink(),
                SizedBox(height: 24.h),
                CustomButton(
                  text: 'Login',
                  onPressed: () {
                    authController.signInWithEmail(
                        email.text.trim(),
                        password.text.trim()
                    );
                    email.clear();
                    password.clear();
                  }
                ),
                SizedBox(height: 90.h), // নিচে স্পেস দেওয়ার জন্য
                _buildSignUpLink(),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Row(
      children: [
        Text(
          'Welcome Back ',
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        Text(
          '👋',
          style: TextStyle(fontSize: 28.sp),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordLink() {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
          );
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size(50.w, 30.h),
          alignment: Alignment.centerLeft,
        ),
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 14.sp,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 14.sp,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          children: [
            const TextSpan(text: "Don't have an account? "),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpScreen()),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}