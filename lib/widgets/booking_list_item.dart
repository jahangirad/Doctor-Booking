import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingListItem extends StatelessWidget {
  final String bookingId;
  final String patientName;

  const BookingListItem({
    Key? key,
    required this.bookingId,
    required this.patientName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.calendar_today_outlined,
              size: 24.sp,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Booking ID: $bookingId",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "Patient: $patientName",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}