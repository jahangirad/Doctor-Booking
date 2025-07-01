import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/appointment_controller.dart';
import '../widgets/booking_list_tile.dart';



class AdminBookingsScreen extends StatelessWidget {
  const AdminBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final AppointmentController controller = Get.put(AppointmentController());

    return Scaffold(
      body: Obx(() {
        if (controller.allAppointments.isEmpty) {
          return const Center(
            child: Text('No Data Found'),
          );
        }
        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: controller.allAppointments.length,
          itemBuilder: (context, index) {
            final bookingData = controller.allAppointments[index];
            return BookingListTile(
              bookingId: bookingData['slip_number']?.toString() ?? 'N/A',
              status: bookingData['payment_status']?.toString() ?? 'Pending',
              doctorName: bookingData['doctor_name']?.toString() ?? 'Unknown Doctor',
            );
          },
          separatorBuilder: (context, index) => Divider(
            height: 1,
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
          ),
        );
      }),
    );
  }
}