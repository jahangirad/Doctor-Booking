import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/appointment_list_item.dart';


class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  int _selectedIndex = 1;

  // ডেটা এখন List of Maps হিসেবে আছে, কোনো মডেল ক্লাস নেই।
  final List<Map<String, String>> appointmentsList = [
    {
      'imagePath': 'assets/img/splash-icon.png',
      'date': 'May 15, 2024',
      'doctorName': 'Dr. Emily Carter',
      'time': '10:00 AM',
    },
    {
      'imagePath': 'assets/img/splash-icon.png',
      'date': 'May 22, 2024',
      'doctorName': 'Dr. Michael Chen',
      'time': '2:00 PM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          children: [
            SizedBox(height: 20.h),
            // Custom App Bar
            Row(
              children: [
                const Spacer(),
                Text(
                  'Appointments',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const Spacer(),
              ],
            ),
            SizedBox(height: 32.h),

            // Upcoming Appointments List - Map থেকে ডেটা নিয়ে উইজেট তৈরি
            ...appointmentsList.map((app) => AppointmentListItem(
              imagePath: app['imagePath']!,
              date: app['date']!,
              doctorName: app['doctorName']!,
              time: app['time']!,
            )),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}