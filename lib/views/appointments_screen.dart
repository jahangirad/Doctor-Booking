import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// আপনার প্রোজেক্টের সঠিক পাথ দিন
import '../controllers/appointment_controller.dart';
import '../widgets/appointment_list_item.dart';
import 'appointment_confirmed_screen.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  // AppointmentController-এর একটি ইনস্ট্যান্স নিন
  final AppointmentController _appointmentController = Get.put(AppointmentController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              // Custom App Bar
              Text(
                'My Appointments',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(height: 32.h),

              // Obx উইজেট দিয়ে Realtime/Reactive লিস্ট দেখানো হচ্ছে
              Expanded(
                child: Obx(() {

                  if (_appointmentController.userAppointments.isEmpty) {
                    return const Center(child: Text("You have no upcoming appointments."));
                  }

                  // ListView.builder ব্যবহার করা ভালো পারফরম্যান্সের জন্য
                  return ListView.builder(
                    itemCount: _appointmentController.userAppointments.length,
                    itemBuilder: (context, index) {
                      // নির্দিষ্ট index-এর অ্যাপয়েন্টমেন্ট ডেটা
                      final appointment = _appointmentController.userAppointments[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentConfirmedScreen(appointmentData: appointment)));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: AppointmentListItem(
                            // আপনার ডেটাবেজের কলামের নাম অনুযায়ী কী-গুলো পরিবর্তন করুন
                            imagePath: appointment['img'] ?? 'N/A', // আপাতত একটি স্ট্যাটিক ইমেজ
                            date: appointment['date'] ?? 'N/A',
                            doctorName: appointment['doctor_name'] ?? 'N/A',
                            time: appointment['time'] ?? 'N/A',
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}