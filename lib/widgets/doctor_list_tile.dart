import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorListTile extends StatelessWidget {
  final String name;
  final String specialty;
  final String availability;
  final String imageUrl;
  final VoidCallback? onEdit; // new

  const DoctorListTile({
    Key? key,
    required this.name,
    required this.specialty,
    required this.availability,
    required this.imageUrl,
    this.onEdit, // new
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32.r,
            backgroundImage: imageUrl.startsWith('http')
                ? NetworkImage(imageUrl)
                : AssetImage(imageUrl) as ImageProvider,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  availability,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  specialty,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onEdit,  // call the callback here
            icon: Icon(
              Icons.edit_outlined,
              color: Theme.of(context).colorScheme.secondary,
              size: 24.sp,
            ),
          )
        ],
      ),
    );
  }
}
