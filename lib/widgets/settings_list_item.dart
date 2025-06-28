import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SettingsListItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ListTile উইজেটটি এই ধরনের আইটেমের জন্য উপযুক্ত
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero, // ListTile-এর ডিফল্ট প্যাডিং সরাতে
      leading: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary, // হালকা ধূসর রঙ
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(
          icon,
          size: 24.sp,
          color: Theme.of(context).colorScheme.onPrimary, // আইকনের রঙ
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.secondary, // টেক্সটের রঙ
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16.sp,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}