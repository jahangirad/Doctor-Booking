import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../services/pdf_service.dart';
import '../widgets/booking_slip_action_tile.dart';
import '../widgets/custom_button.dart';
import 'home_screen.dart';

class AppointmentConfirmedScreen extends StatefulWidget {
  // ডেটা গ্রহণ করার জন্য কনস্ট্রাক্টর
  final Map<String, dynamic> appointmentData;

  const AppointmentConfirmedScreen({Key? key, required this.appointmentData}) : super(key: key);

  @override
  State<AppointmentConfirmedScreen> createState() => _AppointmentConfirmedScreenState();
}

class _AppointmentConfirmedScreenState extends State<AppointmentConfirmedScreen> {
  // PDF সার্ভিস ইনিশিয়েট করা
  final PdfService _pdfService = PdfService();
  bool _isProcessing = false;

  void _handleView() async {
    setState(() => _isProcessing = true);
    await _pdfService.viewBookingSlip(widget.appointmentData);
    setState(() => _isProcessing = false);
  }

  @override
  Widget build(BuildContext context) {
    // appointmentData থেকে স্লিপ নম্বরটি নেওয়া হলো
    final slipNumber = widget.appointmentData['slip_number']?.toString() ?? 'N/A';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Row with Title
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
                'Your appointment is\nconfirmed!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(height: 20.h),

              // Subheading
              Text(
                'You will receive a reminder 1-2 hours before\nyour appointment',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Theme.of(context).colorScheme.secondary,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 40.h),
              GestureDetector(
                onTap: _isProcessing ? null : _handleView,
                child: BookingSlipActionTile(
                  icon: Icons.description_outlined,
                  title: 'View Booking Slip',
                  subtitle: 'Booking ID: $slipNumber',
                ),
              ),

              const Spacer(),

              // Done Button
              CustomButton(
                text: 'Done',
                onPressed: () {
                  Get.toNamed('/main-screen');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}