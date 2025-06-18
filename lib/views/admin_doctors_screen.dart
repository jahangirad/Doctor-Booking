import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/doctor_list_tile.dart';
import 'admin_doctor_details_screen.dart';

class AdminDoctorsScreen extends StatelessWidget {
  const AdminDoctorsScreen({super.key});

  // মডেলের পরিবর্তে Map এর একটি List ব্যবহার করা হয়েছে
  final List<Map<String, String>> doctorsList = const [
    {
      'name': 'Dr. Emily Carter',
      'availability': 'Mon, Tue, Wed',
      'specialty': 'Cardiology',
      'imageUrl': 'assets/img/splash-icon.png', // আপনার ইমেজ পাথ
    },
    {
      'name': 'Dr. Michael Chen',
      'availability': 'Tue, Wed, Thu',
      'specialty': 'Pediatrics',
      'imageUrl': 'assets/img/splash-icon.png', // আপনার ইমেজ পাথ
    },
    {
      'name': 'Dr. Sophia Davis',
      'availability': 'Mon, Wed, Fri',
      'specialty': 'Dermatology',
      'imageUrl': 'assets/img/splash-icon.png', // আপনার ইমেজ পাথ
    },
    {
      'name': 'Dr. Ethan Foster',
      'availability': 'Mon, Tue, Thu',
      'specialty': 'Neurology',
      'imageUrl': 'assets/img/splash-icon.png', // আপনার ইমেজ পাথ
    },
    {
      'name': 'Dr. Olivia Green',
      'availability': 'Tue, Thu, Fri',
      'specialty': 'Orthopedics',
      'imageUrl': 'assets/img/splash-icon.png', // আপনার ইমেজ পাথ
    },
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
                // Handle logout
              },
              tooltip: 'Logout',
            ),
          ],
        ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end, // বাটনকে ডানদিকে পাঠাবে
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminDoctorDetailsScreen()));
                  },
                  icon: Icon(
                    Icons.add,
                    size: 18.sp,
                  ),
                  label: Text(
                    "Add Doctor",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
                    foregroundColor: Theme.of(context).colorScheme.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: doctorsList.length,
              itemBuilder: (context, index) {
                final doctorData = doctorsList[index];
                // Map থেকে ডেটা নিয়ে সরাসরি উইজেটে পাস করা হচ্ছে
                return DoctorListTile(
                  name: doctorData['name']!,
                  availability: doctorData['availability']!,
                  specialty: doctorData['specialty']!,
                  imageUrl: doctorData['imageUrl']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}