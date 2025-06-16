import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';



class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.secondary, size: 24.sp),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Change Password',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Reusable Input Fields
              const CustomTextField(hintText: 'Enter current password'),
              SizedBox(height: 24.h),
              const CustomTextField(hintText: 'Enter new password'),
              SizedBox(height: 24.h),
              const CustomTextField(hintText: 'Confirm new password'),

              // Spacer to push the button to the bottom
              const Spacer(),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: 'Update Password',
                  onPressed: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=> const MainScreen()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}