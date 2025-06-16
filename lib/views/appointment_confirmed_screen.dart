import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/booking_slip_action_tile.dart';
import '../widgets/custom_button.dart';
import 'home_screen.dart';

class AppointmentConfirmedScreen extends StatelessWidget {
  const AppointmentConfirmedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Row with Close Icon and Title
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    const Spacer(),
                    Text(
                      'Appointment Confirmed',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              SizedBox(height: 60.h),

              // Main Heading
              Text(
                'Your appointment is\nconfirmed',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  height: 1.3.h,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(height: 16.h),

              // Subheading
              Text(
                'You will receive a reminder 24 hours before\nyour appointment',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Theme.of(context).colorScheme.secondary,
                  height: 1.5.h,
                ),
              ),
              SizedBox(height: 40.h),

              // Reusable Action Tiles
              const BookingSlipActionTile(
                icon: Icons.download_outlined,
                title: 'Download Booking Slip',
              ),
              SizedBox(height: 20.h),
              const BookingSlipActionTile(
                icon: Icons.description_outlined, // View icon
                title: 'View Booking Slip',
              ),

              // Spacer to push the button to the bottom
              const Spacer(),

              // Done Button
              CustomButton(
                text: 'Done',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}