import 'dart:math';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../views/appointment_confirmed_screen.dart';
import 'auth_controller.dart';
import 'payment_controller.dart';

enum PaymentOption { payNow, payLater }

class AppointmentController extends GetxController {
  final AuthController _authController = Get.put(AuthController());
  final PaymentController _paymentController = Get.put(PaymentController());
  final _supabase = Supabase.instance.client;

  // --- স্টেট ভেরিয়েবল ---
  final isProcessing = false.obs;
  final allAppointments = <Map<String, dynamic>>[].obs;
  final userAppointments = <Map<String, dynamic>>[].obs;

  // --- Stream ---
  Stream<List<Map<String, dynamic>>>? allAppointmentsStream;
  Stream<List<Map<String, dynamic>>>? userAppointmentsStream;

  @override
  void onReady() {
    super.onReady();
    setupRealtimeStreams();
  }

  void setupRealtimeStreams() {
    // ✅ Admin view: All Appointments stream
    allAppointmentsStream = _supabase
        .from('booking')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .map((data) => List<Map<String, dynamic>>.from(data));

    allAppointmentsStream!.listen((data) {
      allAppointments.value = data;
    });

    // ✅ User-specific appointments stream using auth listener
    _authController.supabase.auth.onAuthStateChange.listen((event) {
      final currentUser = _authController.supabase.auth.currentUser;

      if (currentUser != null) {
        userAppointmentsStream = _supabase
            .from('booking')
            .stream(primaryKey: ['id'])
            .eq('uid', currentUser.id)
            .order('created_at', ascending: false)
            .map((data) => List<Map<String, dynamic>>.from(data));

        userAppointmentsStream!.listen((data) {
          userAppointments.value = data;
        });
      } else {
        userAppointments.clear();
      }
    });
  }

  // --- Book Appointment ---
  Future<void> bookAppointment({
    required DateTime? selectedDay,
    required String? selectedTime,
    required bool agreedToTerms,
    required PaymentOption paymentOption,
    required Map<String, dynamic> doctor,
    required String patientName,
    required String patientPhone,
    required String shortNote,
  }) async {
    if (selectedDay == null || selectedTime == null || !agreedToTerms) {
      Get.snackbar('Error', 'Please fill all required fields and agree to the terms.');
      return;
    }

    final currentUser = _authController.supabase.auth.currentUser;
    if (currentUser == null) {
      Get.snackbar('Authentication Error', 'You must be logged in to book an appointment.');
      return;
    }

    isProcessing.value = true;
    try {
      String? trxId;
      double? payAmount;
      String paymentStatus = 'Pending';

      if (paymentOption == PaymentOption.payNow) {
        final paymentSuccess = await _paymentController.makePayment();
        if (paymentSuccess) {
          trxId = _paymentController.paymentIntent?['id'];
          payAmount = (_paymentController.paymentIntent?['amount'] / 100.0);
          paymentStatus = 'Paid';
        } else {
          Get.snackbar('Payment Failed', 'Try again or choose "Pay Later".');
          isProcessing.value = false;
          return;
        }
      }

      final appointmentData = {
        'uid': currentUser.id,
        'slip_number': _generateSlipNumber(),
        'doctor_name': doctor['name'],
        'specialty': doctor['specialty'],
        'img': doctor['image_url'],
        'date': DateFormat('yyyy-MM-dd').format(selectedDay),
        'time': selectedTime,
        'patient_name': patientName,
        'patient_phone': patientPhone,
        'short_note': shortNote.isEmpty ? null : shortNote,
        'payment_status': paymentStatus,
        'pay_amount': payAmount,
        'trx_id': trxId,
      };

      final response = await _supabase.from('booking').insert(appointmentData).select();
      final newAppointmentData = response.first;

      Get.off(() => AppointmentConfirmedScreen(appointmentData: newAppointmentData));

    } on PostgrestException catch (e) {
      Get.snackbar('Database Error', e.message);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isProcessing.value = false;
    }
  }

  String _generateSlipNumber() {
    return (100000 + Random().nextInt(900000)).toString();
  }
}
