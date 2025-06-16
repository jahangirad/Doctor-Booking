import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

import '../widgets/custom_button.dart';
import 'appointment_confirmed_screen.dart';



class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  // Calendar state management এর জন্য
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Time slot selection এর জন্য
  int? _selectedTimeIndex;
  final List<String> _timeSlots = [
    "10:00 AM", "11:00 AM", "12:00 PM",
    "1:00 PM", "2:00 PM", "3:00 PM"
  ];

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay; // প্রাথমিকভাবে আজকের দিন সিলেক্ট করা থাকবে
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        leading: Icon(
          Icons.arrow_back,
          color: Theme.of(context).colorScheme.secondary,
          size: 24.sp,
        ),
        title: Text(
          'Book Appointment',
          style: TextStyle(
            fontFamily: 'Poppins', // পরিবর্তন করা হয়েছে
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            // ডাক্তার এর তথ্য উইজেট
            const _DoctorInfoCard(),
            SizedBox(height: 30.h),
            // তারিখ নির্বাচন সেকশন
            _buildSectionTitle('Select Date'),
            SizedBox(height: 15.h),
            _buildCalendar(),
            SizedBox(height: 30.h),
            // সময় নির্বাচন সেকশন
            _buildSectionTitle('Select Time'),
            SizedBox(height: 15.h),
            _buildTimeSlots(),
            SizedBox(height: 30.h),
            // ইনপুট ফিল্ড
            _buildInputField(hintText: 'Patient Name'),
            SizedBox(height: 20.h),
            _buildInputField(hintText: 'Short note or reason (optional)', maxLines: 4),
            SizedBox(height: 40.h),
          ],
        ),
      ),
      // নিচের বাটন
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: SizedBox(
        width: double.infinity,
          child: CustomButton(
            text: 'Book Appointment',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const AppointmentConfirmedScreen()));
            },
          ),
        ),
      ),
    );
  }

  // বিভিন্ন সেকশনের টাইটেল তৈরির জন্য একটি Helper উইজেট
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Poppins', // পরিবর্তন করা হয়েছে
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  // Calendar উইজেট
  Widget _buildCalendar() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TableCalendar(
        focusedDay: _focusedDay,
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins', // পরিবর্তন করা হয়েছে
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          leftChevronIcon: Icon(Icons.chevron_left, color: Theme.of(context).colorScheme.secondary),
          rightChevronIcon: Icon(Icons.chevron_right, color: Theme.of(context).colorScheme.secondary),
        ),
        calendarStyle: CalendarStyle(
          defaultTextStyle: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp), // পরিবর্তন করা হয়েছে
          weekendTextStyle: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp), // পরিবর্তন করা হয়েছে
          todayDecoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(
            fontFamily: 'Poppins', // পরিবর্তন করা হয়েছে
            fontSize: 14.sp,
            color: Theme.of(context).colorScheme.background,
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(fontFamily: 'Poppins', color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600), // পরিবর্তন করা হয়েছে
          weekendStyle: TextStyle(fontFamily: 'Poppins', color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600), // পরিবর্তন করা হয়েছে
        ),
      ),
    );
  }

  // Time Slot উইজেট
  Widget _buildTimeSlots() {
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: List.generate(_timeSlots.length, (index) {
        bool isSelected = _selectedTimeIndex == index;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedTimeIndex = index;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
            decoration: BoxDecoration(
              color: isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              _timeSlots[index],
              style: TextStyle(
                fontFamily: 'Poppins', // পরিবর্তন করা হয়েছে
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        );
      }),
    );
  }

  // ইনপুট ফিল্ড উইজেট
  Widget _buildInputField({required String hintText, int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: 'Poppins', // পরিবর্তন করা হয়েছে
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 15.sp,
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.primary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      ),
    );
  }
}

// ডাক্তার এর তথ্য প্রদর্শনের জন্য একটি আলাদা উইজেট
class _DoctorInfoCard extends StatelessWidget {
  const _DoctorInfoCard();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dr. Amelia Harper',
              style: TextStyle(
                fontFamily: 'Poppins', // পরিবর্তন করা হয়েছে
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              'Cardiologist',
              style: TextStyle(
                fontFamily: 'Poppins', // পরিবর্তন করা হয়েছে
                fontSize: 16.sp,
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const Spacer(),
        SizedBox(
          width: 80.w,
          height: 80.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            // আপনার অ্যাসেট ফোল্ডারের পাথ ঠিকমতো দিন
            child: Image.asset('assets/img/splash-icon.png', fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }
}