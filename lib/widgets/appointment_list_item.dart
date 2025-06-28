import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppointmentListItem extends StatelessWidget {
  final String imagePath;
  final String date;
  final String doctorName;
  final String time;

  const AppointmentListItem({
    Key? key,
    required this.imagePath,
    required this.date,
    required this.doctorName,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        children: [
          // Doctor's Avatar
          CircleAvatar(
            radius: 28.r,
            backgroundColor: Theme.of(context).colorScheme.primary,
            backgroundImage: NetworkImage(imagePath),
          ),
          SizedBox(width: 16.w),
          // Appointment Details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                '$doctorName · $time',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}