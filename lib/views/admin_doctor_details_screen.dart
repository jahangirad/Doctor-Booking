import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/day_checkbox_tile.dart';
import '../widgets/time_picker_button.dart';

class AdminDoctorDetailsScreen extends StatefulWidget {
  const AdminDoctorDetailsScreen({super.key});

  @override
  State<AdminDoctorDetailsScreen> createState() => _AdminDoctorDetailsScreenState();
}

class _AdminDoctorDetailsScreenState extends State<AdminDoctorDetailsScreen> {
  final Map<String, bool> _availableDays = {
    'Monday': false,
    'Tuesday': false,
    'Wednesday': false,
    'Thursday': false,
    'Friday': false,
    'Saturday': false,
    'Sunday': false,
  };

  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  File? _imageFile;

  // ছবি বেছে নেওয়ার জন্য একটি মেথড
  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // ক্যামেরা বা গ্যালারি বেছে নেওয়ার জন্য ডায়ালগ দেখানোর মেথড
  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Choose Image Source"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Gallery"),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.secondary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Doctor Details',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              // Doctor's Image
              Center(
                child: Stack(
                  children: [
                    // ছবিটি দেখানোর জায়গা
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: _imageFile != null
                          ? Image.file( // নির্বাচিত ছবি থাকলে দেখাবে
                        _imageFile!,
                        height: 250.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                          : Image.asset( // না থাকলে প্লেসহোল্ডার দেখাবে
                        'assets/img/splash-icon.png',
                        height: 250.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // ছবি পরিবর্তনের জন্য বাটন
                    Positioned(
                      bottom: 10.h,
                      right: 10.w,
                      child: InkWell(
                        onTap: _showImageSourceDialog,
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Theme.of(context).colorScheme.background,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Text Fields
              const CustomTextField(hintText: 'Doctor Name'),
              SizedBox(height: 16.h),
              const CustomTextField(hintText: 'Specialty'),
              SizedBox(height: 16.h),
              const CustomTextField(hintText: 'Phone'),
              SizedBox(height: 16.h),
              const CustomTextField(hintText: 'Address'),
              SizedBox(height: 30.h),

              // Available Days
              Text(
                'Available Days',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary),
              ),
              SizedBox(height: 10.h),
              ..._availableDays.keys.map((day) {
                return DayCheckboxTile(
                  day: day,
                  value: _availableDays[day]!,
                  onChanged: (newValue) {
                    setState(() {
                      _availableDays[day] = newValue!;
                    });
                  },
                );
              }).toList(),
              SizedBox(height: 30.h),

              // Available Times
              Text(
                'Available Times',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  TimePickerButton(
                    label: 'Start Time',
                    selectedTime: _startTime,
                    onTimeSelected: (time) {
                      setState(() {
                        _startTime = time;
                      });
                    },
                  ),
                  SizedBox(width: 16.w),
                  TimePickerButton(
                    label: 'End Time',
                    selectedTime: _endTime,
                    onTimeSelected: (time) {
                      setState(() {
                        _endTime = time;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 40.h),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: 'Save',
                  onPressed: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=> const AdminPanelScreen()));
                  },
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
