import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/password_strength_indicator.dart'; // your_app_name পরিবর্তন করুন

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _isPasswordUpdated = false;
  double _passwordStrength = 0.0;
  String _strengthText = '';

  void _checkPasswordStrength(String password) {
    setState(() {
      if (password.isEmpty) {
        _passwordStrength = 0.0;
        _strengthText = '';
      } else if (password.length < 6) {
        _passwordStrength = 0.3;
        _strengthText = 'Weak';
      } else if (password.length < 10) {
        _passwordStrength = 0.6;
        _strengthText = 'Medium';
      } else {
        _passwordStrength = 1.0;
        _strengthText = 'Strong';
      }
    });
  }

  void _updatePassword() {
    // এখানে পাসওয়ার্ড আপডেটের আসল লজিক থাকবে
    // সফলভাবে আপডেট হলে নিচের স্টেট পরিবর্তন হবে
    setState(() {
      _isPasswordUpdated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Reset Your Password',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.secondary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              CustomTextField3(
                hintText: 'New Password',
                isPassword: true,
                onChanged: _checkPasswordStrength,
              ),
              SizedBox(height: 20.h),
              if (_strengthText.isNotEmpty)
                PasswordStrengthIndicator(
                  strength: _passwordStrength,
                  strengthText: _strengthText,
                ),
              SizedBox(height: 20.h),
              const CustomTextField3(
                hintText: 'Confirm New Password',
                isPassword: true,
              ),
              const Spacer(), // বাটন এবং মেসেজকে নিচে ঠেলে দেয়
              CustomButton(
                text: 'Update Password',
                onPressed: _updatePassword,
              ),
              SizedBox(height: 16.h),
              if (_isPasswordUpdated)
                Center(
                  child: Text(
                    'Your password has been updated! You can now log in.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              SizedBox(height: 40.h), // নিচের দিকে কিছু প্যাডিং
            ],
          ),
        ),
      ),
    );
  }
}