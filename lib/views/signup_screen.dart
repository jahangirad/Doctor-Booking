import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'login_screen.dart';



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _agreedToTerms = false;

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
                const CustomTextField(hintText: 'Full Name'),
                SizedBox(height: 16.h),
                const CustomTextField(hintText: 'Email'),
                SizedBox(height: 16.h),
                const CustomTextField(hintText: 'Phone Number'),
                SizedBox(height: 16.h),
                const CustomTextField(hintText: 'Password', isPassword: true),
                SizedBox(height: 16.h),
                const CustomTextField(hintText: 'Confirm Password', isPassword: true),
                SizedBox(height: 20.h),
                _buildTermsAndConditions(),
                SizedBox(height: 30.h),
                CustomButton(
                  text: 'Create Account',
                  onPressed: () {
                    // Handle account creation logic
                  },
                ),
                SizedBox(height: 100.h), // নিচে স্পেস দেওয়ার জন্য
                _buildSignInLink(),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Row(
      children: [
        SizedBox(
          width: 24.w,
          height: 24.h,
          child: Checkbox(
            value: _agreedToTerms,
            onChanged: (bool? value) {
              setState(() {
                _agreedToTerms = value ?? false;
              });
            },
            activeColor: Theme.of(context).colorScheme.surface,
            focusColor: Theme.of(context).colorScheme.surface,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            'I agree to the Terms of Service and Privacy Policy',
            style: TextStyle(
              fontSize: 14.sp,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
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