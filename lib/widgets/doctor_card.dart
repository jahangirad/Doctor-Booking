import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String address;
  final String imageUrl;
  final VoidCallback onViewProfile; // এই নতুন প্রপার্টি যোগ করুন

  const DoctorCard({
    Key? key,
    required this.name,
    required this.specialty,
    required this.address,
    required this.imageUrl,
    required this.onViewProfile, // কনস্ট্রাক্টরে এটি যোগ করুন
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ইমেজ লোড করার জন্য একটি ডাইনামিক উইজেট তৈরি করা
    Widget imageWidget;
    if (imageUrl.startsWith('http')) {
      imageWidget = Image.network(
        imageUrl,
        width: 100.w,
        height: 120.h,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          // এরর হলে একটি ফলব্যাক ইমেজ দেখানো হবে
          return Image.asset(
            'assets/img/splash-icon.png', // আপনার ফলব্যাক অ্যাসেট ইমেজ
            width: 100.w,
            height: 120.h,
            fit: BoxFit.cover,
          );
        },
      );
    } else {
      imageWidget = Image.asset(
        imageUrl,
        width: 100.w,
        height: 120.h,
        fit: BoxFit.cover,
      );
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  specialty,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  address,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 12.h),
                ElevatedButton(
                  onPressed: onViewProfile, // এখানে কলব্যাক ফাংশনটি ব্যবহার করুন
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                  ),
                  child: Text(
                    'View Profile',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 16.w),
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: imageWidget, // এখানে তৈরি করা উইজেটটি ব্যবহার করুন
          )
        ],
      ),
    );
  }
}