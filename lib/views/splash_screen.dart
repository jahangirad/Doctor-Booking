import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/auth_check_controller.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final AuthCheckController authCheckController = Get.put(AuthCheckController());

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      authCheckController.redirectUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            'assets/img/splash-icon.png',
            width: double.infinity,
            height: 380.h,
            fit: BoxFit.cover,
          ),

          SizedBox(height: 60.h),

          // প্রধান টেক্সট (এখন Poppins ফন্টে দেখাবে)
          Text(
            'Book your doctor in\nseconds',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 34.sp,
              fontWeight: FontWeight.bold, // Poppins-Bold ব্যবহার হবে
              color: Theme.of(context).colorScheme.secondary,
              height: 1.2,
            ),
          ),
          SizedBox(height: 30.h),
          // লোডিং রিসোর্স এবং პროგრେਸ বার
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // এই টেক্সটও Poppins ফন্টে দেখাবে
                Text(
                  'Loading resources...',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Theme.of(context).colorScheme.secondary, // হালকা রঙ
                  ),
                ),
                SizedBox(height: 12.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Container(
                    height: 8.h,
                    color: Colors.grey.shade200,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: 0.6,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onSecondary,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 60.h),
        ],
      ),
    );
  }
}