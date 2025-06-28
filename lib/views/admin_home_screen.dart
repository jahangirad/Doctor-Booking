import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/booking_list_item.dart';
import '../widgets/doctor_list_item.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                "Manage Doctors",
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary),
              ),
              SizedBox(height: 10.h),
              const DoctorListItem(
                imageUrl: 'assets/img/splash-icon.png', // আপনার সঠিক ইমেজ পাথ দিন
                name: 'Dr. Sophia Hayes',
                specialty: 'Cardiology',
              ),
              const DoctorListItem(
                imageUrl: 'assets/img/splash-icon.png', // আপনার সঠিক ইমেজ পাথ দিন
                name: 'Dr. Noah Parker',
                specialty: 'Pediatrics',
              ),
              const DoctorListItem(
                imageUrl: 'assets/img/splash-icon.png', // আপনার সঠিক ইমেজ পাথ দিন
                name: 'Dr. Isabella Reed',
                specialty: 'Dermatology',
              ),
              SizedBox(height: 30.h),
              Text(
                "Manage Bookings",
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary),
              ),
              SizedBox(height: 10.h),
              const BookingListItem(
                bookingId: '12345',
                patientName: 'Owen Bennett',
              ),
              const BookingListItem(
                bookingId: '67890',
                patientName: 'Lily Turner',
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}