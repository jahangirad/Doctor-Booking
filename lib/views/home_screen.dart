import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/doctor_card.dart';
import '../widgets/filter_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedFilterIndex = 1;
  int _bottomNavIndex = 0;

  final List<String> filters = ["All", "Cardiologist", "Dermatologist", "Neurologist"];

  // ডেমো ডেটা, এখন মডেল ছাড়া সরাসরি ম্যাপ লিস্ট হিসেবে
  final List<Map<String, String>> doctors = [
    {
      'name': 'Dr. Ethan Carter',
      'specialty': 'Cardiologist',
      'address': '123 Main St, Anytown',
      'imageUrl': 'assets/img/splash-icon.png',
    },
    {
      'name': 'Dr. Olivia Bennett',
      'specialty': 'Cardiologist',
      'address': '456 Oak Ave, Anytown',
      'imageUrl': 'assets/img/splash-icon.png',
    },
    {
      'name': 'Dr. Noah Thompson',
      'specialty': 'Cardiologist',
      'address': '789 Pine Ln, Anytown',
      'imageUrl': 'assets/img/splash-icon.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.secondary, size: 24.sp),
        title: Text(
          'Find a doctor',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search for a doctor',
                  hintStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 16.sp),
                  prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.onPrimary, size: 24.sp),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.primary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 45.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  itemBuilder: (context, index) {
                    return FilterButton(
                      text: filters[index],
                      isSelected: _selectedFilterIndex == index,
                      onTap: () {
                        setState(() {
                          _selectedFilterIndex = index;
                        });
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Cardiologist',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  return DoctorCard(
                    name: doctor['name']!,
                    specialty: doctor['specialty']!,
                    address: doctor['address']!,
                    imageUrl: doctor['imageUrl']!,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF47C6AD),
        unselectedItemColor: Colors.grey[400],
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
        unselectedLabelStyle: TextStyle(fontSize: 12.sp),
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.calendar_today),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
                    child: Text(
                      '12',
                      style: TextStyle(color: Colors.white, fontSize: 8.sp),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
            label: 'Appointments',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Messages'),
          const BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}