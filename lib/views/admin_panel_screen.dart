import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import 'admin_bookings_screen.dart';
import 'admin_doctors_screen.dart';
import 'admin_home_screen.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  final AuthController authController = Get.put(AuthController());
  int _currentIndex = 0;

  // পেইজগুলোর তালিকা
  final List<Widget> _pages = [
    const AdminHomeScreen(),
    AdminDoctorsScreen(),
    const AdminBookingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        title: Text(
          "Admin Panel",
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Theme.of(context).colorScheme.secondary),
            onPressed: () {
              authController.logoutUser();
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: const Color(0xFF006A60),
        unselectedItemColor: Colors.grey.shade600,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Doctors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_today),
            label: 'Bookings',
          ),
        ],
      ),
    );
  }
}
