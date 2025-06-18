import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingListTile extends StatelessWidget {
  final String bookingId;
  final String status;
  final String doctorName;

  const BookingListTile({
    Key? key,
    required this.bookingId,
    required this.status,
    required this.doctorName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Booking ID: $bookingId",
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  doctorName,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}