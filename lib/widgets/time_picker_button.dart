import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimePickerButton extends StatelessWidget {
  final String label;
  final TimeOfDay? selectedTime;
  final Function(TimeOfDay) onTimeSelected;

  const TimePickerButton({
    Key? key,
    required this.label,
    required this.selectedTime,
    required this.onTimeSelected,
  }) : super(key: key);

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      onTimeSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => _selectTime(context),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: Text(
              selectedTime == null ? label : selectedTime!.format(context),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}