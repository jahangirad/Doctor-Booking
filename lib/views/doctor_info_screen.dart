import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_button.dart';
import '../widgets/info_card.dart';
import 'book_appointment_screen.dart';

class DoctorInfoScreen extends StatelessWidget {
  const DoctorInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.secondary),
          onPressed: () {
            // back button logic
          },
        ),
        title: Text(
          'Doctor Info',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              // Doctor's Image
              CircleAvatar(
                radius: 70.r,
                backgroundImage: const AssetImage('assets/img/splash-icon.png'),
              ),
              SizedBox(height: 20.h),
              // Doctor's Name and Speciality
              Text(
                'Dr. Rahim Uddin',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Cardiologist',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Clinic Name',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              SizedBox(height: 30.h),
              // Info Cards Section
              InfoCard(
                icon: Icons.location_on_outlined,
                title: 'Address',
                subtitle: '123 Main Street, Anytown, USA',
              ),
              SizedBox(height: 20.h),
              InfoCard(
                icon: Icons.calendar_today_outlined,
                title: 'Available Dates / Days',
                subtitle: 'Available: Sunday - Thursday Time: 10:00 AM - 2:00 PM',
              ),
              SizedBox(height: 20.h),
              InfoCard(
                icon: Icons.phone_outlined,
                title: 'Phone Number',
                subtitle: '', // সাবটাইটেল খালি থাকবে
              ),
              SizedBox(height: 40.h),
              // Action Buttons
              CustomButton(
                text: 'Call Now',
                onPressed: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
                },
              ),
              SizedBox(height: 12.h),
              Text(
                'Call for appointment',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              SizedBox(height: 12.h),
              CustomButton(
                text: 'Book Appointment',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const BookAppointmentScreen()));
                },
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}