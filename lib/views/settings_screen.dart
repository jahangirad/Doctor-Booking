import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/settings_list_item.dart';
import 'appointments_screen.dart';
import 'change_password_screen.dart';
import 'contact_screen.dart';
import 'edit_profile_screen.dart';
import 'terms_of_service_screen.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final AuthController authController = Get.put(AuthController());

  String _getThemeName(AdaptiveThemeMode mode) {
    switch (mode) {
      case AdaptiveThemeMode.light:
        return 'Light';
      case AdaptiveThemeMode.dark:
        return 'Dark';
      case AdaptiveThemeMode.system:
      default:
        return 'System Default';
    }
  }

  // পপ-আপ দেখানোর এই মেথডটি একই থাকবে
  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text('Choose Theme', style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<AdaptiveThemeMode>(
                title: Text('Light', style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                value: AdaptiveThemeMode.light,
                groupValue: AdaptiveTheme.of(context).mode,
                onChanged: (value) {
                  AdaptiveTheme.of(context).setLight();
                  Navigator.of(dialogContext).pop();
                },
                activeColor: Theme.of(context).colorScheme.onSecondary,
              ),
              RadioListTile<AdaptiveThemeMode>(
                title: Text('Dark', style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                value: AdaptiveThemeMode.dark,
                groupValue: AdaptiveTheme.of(context).mode,
                onChanged: (value) {
                  AdaptiveTheme.of(context).setDark();
                  Navigator.of(dialogContext).pop();
                },
                activeColor: Theme.of(context).colorScheme.onSecondary,
              ),
              RadioListTile<AdaptiveThemeMode>(
                title: Text('System Default', style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                value: AdaptiveThemeMode.system,
                groupValue: AdaptiveTheme.of(context).mode,
                onChanged: (value) {
                  AdaptiveTheme.of(context).setSystem();
                  Navigator.of(dialogContext).pop();
                },
                activeColor: Theme.of(context).colorScheme.onSecondary,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Settings',
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
            children: [
              InkWell(
                onTap: () {
                  _showThemeDialog(context); // ট্যাপ করলে পপ-আপ খুলবে
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h), // ListTile এর মতো দেখতে প্যাডিং
                  child: Row(
                    children: [
                      // আইকনের জন্য কন্টেইনার (আপনার ডিজাইন অনুযায়ী)
                      Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          Icons.palette_outlined,
                          size: 24.sp,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      // টাইটেল
                      Text(
                        'Theme',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      // মাঝখানের খালি জায়গা
                      const Spacer(),
                      // ডান দিকে থিমের নাম
                      Text(
                        _getThemeName(AdaptiveTheme.of(context).mode),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      // ডান দিকের তীর চিহ্ন
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16.sp,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              SettingsListItem(
                icon: Icons.person_outline,
                title: 'Edit Profile',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProfileScreen()));
                },
              ),
              SizedBox(height: 24.h),
              SettingsListItem(
                icon: Icons.lock_outline,
                title: 'Change Password',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ChangePasswordScreen()));
                },
              ),
              SizedBox(height: 24.h),
              SettingsListItem(
                icon: Icons.calendar_today_outlined,
                title: 'My Appointments',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const AppointmentsScreen()));
                },
              ),
              SizedBox(height: 24.h),
              SettingsListItem(
                icon: Icons.help_outline,
                title: 'Contact Support',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const ContactScreen()));
                },
              ),
              SizedBox(height: 24.h),
              SettingsListItem(
                icon: Icons.description_outlined,
                title: 'Terms & Conditions',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const TermsOfServiceScreen()));
                },
              ),

              // Spacer to push logout button to the bottom
              const Spacer(),

              // Logout Button
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: 'Logout',
                  onPressed: () {
                    authController.logoutUser();
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