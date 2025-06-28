import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({Key? key}) : super(key: key);

  // Terms of Service টেক্সট এখানে একটি ভ্যারিয়েবলে রাখা হয়েছে
  final String termsText = """Welcome to our medical appointment app! By using our services, you agree to the following terms and conditions. Please read them carefully.
1. Acceptance of Terms: By accessing or using our app, you agree to be bound by these terms. If you do not agree, please do not use our services.
2. Service Description: Our app facilitates scheduling and managing medical appointments. We do not provide medical advice or services directly.
3. User Accounts: You must create an account to use our app. You are responsible for maintaining the confidentiality of your account information.
4. Privacy Policy: Your privacy is important to us. Please review our Privacy Policy to understand how we collect, use, and protect your information.
5. Appointment Management: You can schedule, reschedule, or cancel appointments through our app. Please adhere to the cancellation policies of the respective healthcare providers.
6. Communication: We may send you notifications regarding your appointments or updates to our services. You can manage your notification preferences in the app settings.
7. Disclaimer of Liability: We are not liable for any medical advice, treatment, or services provided by healthcare providers. We are not responsible for any errors or omissions in the information provided.
8. Modifications to Terms: We reserve the right to modify these terms at any time. We will notify you of any significant changes.
9. Termination: We may terminate or suspend your account if you violate these terms.
10. Governing Law: These terms are governed by the laws of [Your Jurisdiction]. If you have any questions or concerns, please contact us at [Your Contact Information]. Thank you for using our app!""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w).copyWith(top: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Bar with Close Icon and Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, size: 24.sp, color: Theme.of(context).colorScheme.secondary),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Text(
                    'Terms of Service',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  SizedBox(width: 48.w), // IconButton এর জায়গার জন্য স্পেস
                ],
              ),
              SizedBox(height: 24.h),

              // Scrollable Text Content
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    termsText,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Theme.of(context).colorScheme.secondary,
                      height: 1.6, // লাইনগুলোর মধ্যে স্পেস বাড়ানোর জন্য
                    ),
                  ),
                ),
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}