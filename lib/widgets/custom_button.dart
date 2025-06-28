// lib/widgets/custom_button.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // পুরো প্রস্থ জুড়ে থাকবে
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.onSecondary, // বাটনের কালার
          foregroundColor: Theme.of(context).primaryColor, // টেক্সটের কালার
          padding: EdgeInsets.symmetric(vertical: 18.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0, // কোন shadow থাকবে না
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}