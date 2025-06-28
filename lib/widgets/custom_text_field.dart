import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary,
        fontSize: 16.sp,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 16.sp,
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.primary,
        contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none, // কোন বর্ডার থাকবে না
        ),
      ),
    );
  }
}

class CustomTextField2 extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextEditingController controller;

  const CustomTextField2({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary,
        fontSize: 16.sp,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 16.sp,
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.primary,
        contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        suffixIconColor: const Color(0xFF6A7E8A),
      ),
    );
  }
}


class CustomTextField3 extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool isPassword;
  final Function(String)? onChanged;

  const CustomTextField3({
    super.key,
    required this.hintText,
    this.controller,
    this.isPassword = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword, // পাসওয়ার্ড আড়াল করার জন্য
      onChanged: onChanged,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary,
        fontSize: 16.sp,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary, // ডিজাইন অনুযায়ী কালার
          fontSize: 16.sp,
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.primary, // ফিল্ডের ব্যাকগ্রাউন্ড কালার
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 20.w,
        ),
      ),
    );
  }
}