import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final double strength; // 0.0 থেকে 1.0 এর মধ্যে একটি মান
  final String strengthText;

  const PasswordStrengthIndicator({
    super.key,
    required this.strength,
    required this.strengthText,
  });

  Color _getStrengthColor() {
    if (strength < 0.4) return Colors.red;
    if (strength < 0.8) return const Color(0xFF38B6FF); // ছবিতে ব্যবহৃত নীল কালার
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password Strength: $strengthText',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: LinearProgressIndicator(
            value: strength,
            minHeight: 8.h,
            backgroundColor: const Color(0xFFE0E0E0), // ইনডিকেটরের ব্যাকগ্রাউন্ড
            valueColor: AlwaysStoppedAnimation<Color>(_getStrengthColor()),
          ),
        ),
      ],
    );
  }
}