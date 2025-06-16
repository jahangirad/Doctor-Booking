import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/doctor_card.dart';
import '../widgets/filter_button.dart';
import 'doctor_info_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedFilterIndex = 0;

  final List<String> filters = ["All", "Cardiologist", "Dermatologist", "Neurologist"];

  final List<Map<String, String>> doctors = [
    {
      'name': 'Dr. Ethan Carter',
      'specialty': 'Cardiologist',
      'address': '123 Main St, Anytown',
      'imageUrl': 'assets/img/splash-icon.png',
    },
    {
      'name': 'Dr. Olivia Bennett',
      'specialty': 'Dermatologist', // Changed for filtering example
      'address': '456 Oak Ave, Anytown',
      'imageUrl': 'assets/img/splash-icon.png',
    },
    {
      'name': 'Dr. Noah Thompson',
      'specialty': 'Neurologist', // Changed for filtering example
      'address': '789 Pine Ln, Anytown',
      'imageUrl': 'assets/img/splash-icon.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Scaffold এখন HomeScreen এর অংশ, যা ঠিক আছে।
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        title: Text(
          'Find a doctor',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
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
                'All Doctors',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(height: 16.h),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  // DoctorCard-এ onTap যোগ করে DoctorInfoScreen-এ নেভিগেট করা হয়েছে
                  return GestureDetector(
                    onTap: (){
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorInfoScreen(doctor: doctor)));
                    },
                    child: DoctorCard(
                      name: doctor['name']!,
                      specialty: doctor['specialty']!,
                      address: doctor['address']!,
                      imageUrl: doctor['imageUrl']!,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}