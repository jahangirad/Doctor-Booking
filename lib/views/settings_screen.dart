import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_button.dart';
import '../widgets/settings_list_item.dart';
import 'appointments_screen.dart';
import 'change_password_screen.dart';
import 'contact_screen.dart';
import 'edit_profile_screen.dart';
import 'terms_of_service_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

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
              // Settings Items List
              SettingsListItem(
                icon: Icons.person_outline,
                title: 'Edit Profile',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const EditProfileScreen()));
                },
              ),
              SizedBox(height: 24.h),
              SettingsListItem(
                icon: Icons.lock_outline,
                title: 'Change Password',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const ChangePasswordScreen()));
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
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
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