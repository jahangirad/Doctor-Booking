import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'appointments_screen.dart';
import 'home_screen.dart';
import 'settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // বর্তমান সিলেক্টেড পেজের ইনডেক্স

  // যে পেজগুলো দেখানো হবে তাদের লিস্ট
  static final List<Widget> _pages = <Widget>[
    const HomeScreen(),
    const AppointmentsScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // বডি হিসেবে বর্তমান সিলেক্টেড পেজটি দেখানো হচ্ছে
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,

        // --- রঙের সমস্যার সমাধান ---
        // থিমের উপর নির্ভর না করে সরাসরি রঙ ব্যবহার করা হয়েছে
        selectedItemColor: Theme.of(context).colorScheme.onPrimary, // একটি উজ্জ্বল নীল রঙ (Selected)
        unselectedItemColor: Theme.of(context).colorScheme.secondary, // একটি ধূসর রঙ (Unselected)

        backgroundColor: Theme.of(context).colorScheme.primary, // ন্যাভবার-এর ব্যাকগ্রাউন্ড
        elevation: 5,

        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.sp),
        unselectedLabelStyle: TextStyle(fontSize: 12.sp),
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
            icon: Stack(
              clipBehavior: Clip.none, // যাতে badge বাইরে দেখা যায়
              children: [
                const Icon(Icons.calendar_today),
                Positioned(
                  right: -5,
                  top: -5,
                  child: Container(
                    padding: EdgeInsets.all(2.r),
                    decoration: BoxDecoration(
                      color: Colors.red, // Badge-এর রঙ
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(minWidth: 16.w, minHeight: 16.h),
                    child: Text(
                      '12',
                      style: TextStyle(color: Colors.white, fontSize: 8.sp, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
            label: 'Appointments',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
      ),
    );
  }
}