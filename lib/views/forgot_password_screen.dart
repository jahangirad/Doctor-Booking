import 'package:doctor_booking/views/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // এই state টি ট্র্যাক করবে যে রিসেট লিঙ্ক পাঠানো হয়েছে কিনা
  bool _isLinkSent = false;

  void _sendResetLink() {
    // এখানে আপনার ইমেইল পাঠানোর লজিক থাকবে
    // আপাতত, আমরা শুধু state পরিবর্তন করব
    setState(() {
      _isLinkSent = true;
      Navigator.push(context, MaterialPageRoute(builder: (context)=> ResetPasswordScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.secondary),
          onPressed: () {
            // back বাটনে প্রেস করলে কি হবে তা এখানে লিখুন
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                'Forgot Password?',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "Don't worry, we'll help you reset it.",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(height: 40.h),
              const CustomTextField(
                hintText: 'Email address',
              ),
              SizedBox(height: 30.h),
              CustomButton(
                text: 'Send Reset Link',
                onPressed: _sendResetLink,
              ),
              const Spacer(), // বাকি সব খালি জায়গা নিয়ে নিবে
              if (_isLinkSent)
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 40.h),
                    child: Text(
                      "We've sent a password reset link to your email.\nPlease check your inbox.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}