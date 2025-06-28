import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingSlipActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle; // নতুন যুক্ত করা হয়েছে

  const BookingSlipActionTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle, // কনস্ট্রাকটরে যুক্ত করা হয়েছে
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Icon Container
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            icon,
            size: 24.sp,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        SizedBox(width: 16.w),
        // Title and Subtitle Column
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            SizedBox(height: 4.h),
            // হার্ডকোডেড টেক্সট পরিবর্তন করে ডাইনামিক করা হয়েছে
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14.sp,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}