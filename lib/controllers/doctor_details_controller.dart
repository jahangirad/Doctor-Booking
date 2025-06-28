import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DoctorDetailsController extends GetxController {
  var doctorList = <Map<String, dynamic>>[].obs;
  final supabase = Supabase.instance.client;

  Stream<List<Map<String, dynamic>>>? doctorStream;

  @override
  void onInit() {
    super.onInit();
    setupRealtime();
  }

  void setupRealtime() {
    doctorStream = supabase
        .from('doctors')
        .stream(primaryKey: ['id'])
        .map((data) => List<Map<String, dynamic>>.from(data));

    // Listen to the stream and update doctorList
    doctorStream!.listen((data) {
      doctorList.value = data;
      print('Doctor list updated: ${doctorList.length} items');
    });
  }

  Future<void> saveDoctorDetails({
    required String doctorName,
    required String clinicName,
    required String specialty,
    required String phone,
    required String address,
    required List<String> availableDays,
    required String? startTime,
    required String? endTime,
    required File? imageFile,
  }) async {
    try {
      String? imageUrl;

      if (imageFile != null) {
        final fileName = 'doctor_${DateTime.now().millisecondsSinceEpoch}.${imageFile.path.split('.').last}';
        final filePath = 'doctor_images/$fileName';
        final fileBytes = await imageFile.readAsBytes();

        await supabase.storage.from('image').uploadBinary(
          filePath,
          fileBytes,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );

        imageUrl = supabase.storage.from('image').getPublicUrl(filePath);
      }

      await supabase.from('doctors').insert({
        'name': doctorName,
        'clinic_name': clinicName,
        'specialty': specialty,
        'phone': phone,
        'address': address,
        'available_days': availableDays,
        'start_time': startTime,
        'end_time': endTime,
        'image_url': imageUrl,
      });

      Get.snackbar(
        'Success',
        'Doctor details saved!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> updateDoctorDetails({
    required int doctorId,
    required String doctorName,
    required String clinicName,
    required String specialty,
    required String phone,
    required String address,
    required List<String> availableDays,
    required String? startTime,
    required String? endTime,
    required File? imageFile,
  }) async {
    try {
      String? imageUrl;

      if (imageFile != null) {
        final fileName = 'doctor_${DateTime.now().millisecondsSinceEpoch}.${imageFile.path.split('.').last}';
        final filePath = 'doctor_images/$fileName';
        final fileBytes = await imageFile.readAsBytes();

        await supabase.storage.from('image').uploadBinary(
          filePath,
          fileBytes,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );

        imageUrl = supabase.storage.from('image').getPublicUrl(filePath);
      }

      final updateData = {
        'name': doctorName,
        'clinic_name': clinicName,
        'specialty': specialty,
        'phone': phone,
        'address': address,
        'available_days': availableDays,
        'start_time': startTime,
        'end_time': endTime,
      };

      // যদি নতুন ইমেজ আপলোড করা হয় তাহলে তা ডাটা তে যোগ করো
      if (imageUrl != null) {
        updateData['image_url'] = imageUrl;
      }

      await supabase.from('doctors').update(updateData).eq('id', doctorId);

      Get.snackbar(
        'Success',
        'Doctor details updated!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
