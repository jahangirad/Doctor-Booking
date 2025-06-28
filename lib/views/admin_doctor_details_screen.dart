import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/doctor_details_controller.dart';
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

  final doctorName = TextEditingController();
  final clinicName = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();

  //Dropdown
  final List<String> _specialties = [
    'Cardiologist',
    'Dermatologist',
    'Pediatrician',
    'Orthopedic',
    'General Physician',
  ];

  String? _selectedSpecialty;

  final DoctorDetailsController doctorDetailsController = Get.put(DoctorDetailsController());


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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: _imageFile != null
                          ? Image.file(
                        _imageFile!,
                        height: 250.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                          : Container(
                        height: 250.h,
                        width: double.infinity,
                        color: Theme.of(context).colorScheme.primary,
                        alignment: Alignment.center,
                        child: Text(
                          "Select Image",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    ),
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
              CustomTextField(hintText: 'Doctor Name', controller: doctorName,),
              SizedBox(height: 16.h),
              CustomTextField(hintText: 'Clinic Name', controller: clinicName,),
              SizedBox(height: 16.h),
              Container(
                height: 60.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedSpecialty,
                    hint: Text(
                      'Select Specialty',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 16.sp,
                      ),
                    ),
                    icon: Icon(Icons.arrow_drop_down, color: Theme.of(context).colorScheme.onPrimary),
                    dropdownColor: Theme.of(context).colorScheme.primary,
                    items: _specialties.map((specialty) {
                      return DropdownMenuItem(
                        value: specialty,
                        child: Text(
                          specialty,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 16.sp,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedSpecialty = value!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              CustomTextField(hintText: 'Phone', controller: phone,),
              SizedBox(height: 16.h),
              CustomTextField(hintText: 'Address', controller: address,),
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
                      final selectedDays = _availableDays.entries
                          .where((e) => e.value)
                          .map((e) => e.key)
                          .toList();

                      doctorDetailsController.saveDoctorDetails(
                        doctorName: doctorName.text.trim(),
                        clinicName: clinicName.text.trim(),
                        specialty: _selectedSpecialty ?? '',
                        phone: phone.text.trim(),
                        address: address.text.trim(),
                        availableDays: selectedDays,
                        startTime: _startTime?.format(context),
                        endTime: _endTime?.format(context),
                        imageFile: _imageFile,
                      );
                    }
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
