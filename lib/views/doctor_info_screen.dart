import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/custom_button.dart';
import '../widgets/info_card.dart';
import 'book_appointment_screen.dart';

class DoctorInfoScreen extends StatelessWidget {
  // ডেটা গ্রহণ করার জন্য একটি ভ্যারিয়েবল ও কনস্ট্রাক্টর যোগ করা হয়েছে
  final Map<String, dynamic> doctor;
  const DoctorInfoScreen({super.key, required this.doctor});

  // ফোন কল করার জন্য একটি হেল্পার ফাংশন
  Future<void> _makePhoneCall(String? phoneNumber) async {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      Get.snackbar('Error', 'Phone number not available');
      return;
    }
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      Get.snackbar('Error', 'Could not launch phone call');
    }
  }

  @override
  Widget build(BuildContext context) {
    // ডেটা থেকে ভ্যালুগুলো বের করে আনা
    final String name = doctor['name'] ?? 'N/A';
    final String specialty = doctor['specialty'] ?? 'N/A';
    final String clinicName = doctor['clinic_name'] ?? 'N/A';
    final String address = doctor['address'] ?? 'No address provided';
    final String phone = doctor['phone'] ?? 'N/A';
    final String? imageUrl = doctor['image_url'];

    // Available days and time format করা
    final List<dynamic> availableDays = doctor['available_days'] ?? [];
    final String daysString = availableDays.isNotEmpty ? availableDays.join(', ') : 'Not specified';
    final String startTime = doctor['start_time'] ?? '';
    final String endTime = doctor['end_time'] ?? '';
    final String availability = 'Available: $daysString\nTime: $startTime - $endTime';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.secondary),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
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
                // নেটওয়ার্ক থেকে ইমেজ লোড করা হচ্ছে, না থাকলে ফলব্যাক ইমেজ দেখানো হবে
                backgroundImage: (imageUrl != null && imageUrl.isNotEmpty)
                    ? NetworkImage(imageUrl)
                    : const AssetImage('assets/img/splash-icon.png') as ImageProvider,
                onBackgroundImageError: (_, __) {
                  // যদি ইমেজ লোড করতে কোনো এরর হয়
                },
              ),
              SizedBox(height: 20.h),
              // Doctor's Name and Speciality
              Text(
                name,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                specialty,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                clinicName,
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
                subtitle: address,
              ),
              SizedBox(height: 20.h),
              InfoCard(
                icon: Icons.calendar_today_outlined,
                title: 'Available Dates / Days & Time',
                subtitle: availability,
              ),
              SizedBox(height: 20.h),
              InfoCard(
                icon: Icons.phone_outlined,
                title: 'Phone Number',
                subtitle: phone,
              ),
              SizedBox(height: 40.h),
              // Action Buttons
              CustomButton(
                text: 'Call Now',
                onPressed: () {
                  _makePhoneCall(phone);
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
                  // বুকিং স্ক্রিনে doctor-এর আইডি বা ডেটা পাস করতে পারেন
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> BookAppointmentScreen(doctor: doctor,)));
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