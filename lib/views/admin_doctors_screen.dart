import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/doctor_details_controller.dart';
import '../widgets/doctor_list_tile.dart';
import 'admin_doctor_details_screen.dart';
import 'admin_edit_doctor_screen.dart';

class AdminDoctorsScreen extends StatelessWidget {
  AdminDoctorsScreen({super.key});

  final DoctorDetailsController controller = Get.put(DoctorDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AdminDoctorDetailsScreen()),
                    );
                  },
                  icon: Icon(
                    Icons.add,
                    size: 18.sp,
                  ),
                  label: Text(
                    "Add Doctor",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
                    foregroundColor: Theme.of(context).colorScheme.background,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.doctorList.isEmpty) {
                return const Center(child: Text('No doctors found'));
              }
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: controller.doctorList.length,
                itemBuilder: (context, index) {
                  final doctorData = controller.doctorList[index];
                  return DoctorListTile(
                    name: doctorData['name'] ?? '',
                    availability: (doctorData['available_days'] as List<dynamic>?)?.join(', ') ?? '',
                    specialty: doctorData['specialty'] ?? '',
                    imageUrl: doctorData['image_url'] ?? 'assets/img/splash-icon.png',
                    onEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminEditDoctorScreen(
                            doctorData: doctorData,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
