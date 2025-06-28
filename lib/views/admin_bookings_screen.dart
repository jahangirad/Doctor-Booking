import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/booking_list_tile.dart';

class AdminBookingsScreen extends StatelessWidget {
  const AdminBookingsScreen({super.key});

  // মডেলের পরিবর্তে Map এর একটি List ব্যবহার করা হয়েছে
  final List<Map<String, String>> bookingsList = const [
    {
      'id': '12345',
      'status': 'Confirmed',
      'doctor': 'Dr. Emily Carter',
    },
    {
      'id': '67890',
      'status': 'Pending',
      'doctor': 'Dr. Michael Chen',
    },
    {
      'id': '24680',
      'status': 'Confirmed',
      'doctor': 'Dr. Olivia Davis',
    },
    {
      'id': '13579',
      'status': 'Pending',
      'doctor': 'Dr. Ethan Foster',
    },
    {
      'id': '97531',
      'status': 'Confirmed',
      'doctor': 'Dr. Sophia Green',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: bookingsList.length,
        itemBuilder: (context, index) {
          final bookingData = bookingsList[index];
          // Map থেকে ডেটা নিয়ে সরাসরি উইজেটে পাস করা হচ্ছে
          return BookingListTile(
            bookingId: bookingData['id']!,
            status: bookingData['status']!,
            doctorName: bookingData['doctor']!,
          );
        },
        // আইটেমগুলোর মধ্যে একটি হালকা Divider যোগ করা হয়েছে
        separatorBuilder: (context, index) => Divider(
          height: 1,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}