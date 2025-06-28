import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DayCheckboxTile extends StatelessWidget {
  final String day;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const DayCheckboxTile({
    Key? key,
    required this.day,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: Theme.of(context).colorScheme.primary,
              side: BorderSide(color: Theme.of(context).colorScheme.surface, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              day,
              style: TextStyle(
                fontSize: 16.sp,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}