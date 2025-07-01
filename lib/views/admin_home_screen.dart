import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/appointment_controller.dart';
import '../controllers/doctor_details_controller.dart';
import '../widgets/booking_list_item.dart';
import '../widgets/doctor_list_item.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DoctorDetailsController doctorController = Get.put(DoctorDetailsController());
    final AppointmentController appointmentController = Get.put(AppointmentController());

    return Scaffold(
      body: Obx(
            () => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Text(
                  "Manage Doctors",
                  style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary),
                ),
                SizedBox(height: 10.h),
                if (doctorController.doctorList.isEmpty)
                  const Center(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('No Data Found'),
                  ))
                else
                  ...doctorController.doctorList.map((doctor) {
                    return DoctorListItem(
                      imageUrl: doctor['image_url'] ?? 'assets/img/splash-icon.png', // ফলব্যাক ইমেজ
                      name: doctor['name']?.toString() ?? 'No Name',
                      specialty: doctor['specialty']?.toString() ?? 'No Specialty',
                    );
                  }).toList(),

                SizedBox(height: 30.h),
                Text(
                  "Manage Bookings",
                  style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary),
                ),
                SizedBox(height: 10.h),
                if (appointmentController.allAppointments.isEmpty)
                  const Center(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('No Data Found'),
                  ))
                else
                  ...appointmentController.allAppointments.take(3).map((booking) {
                    return BookingListItem(
                      bookingId: booking['slip_number']?.toString() ?? 'N/A',
                      patientName: booking['patient_name']?.toString() ?? 'No Name',
                    );
                  }).toList(),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}