import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

// আপনার প্রোজেক্টের সঠিক পাথ দিন
import '../controllers/appointment_controller.dart';
import '../widgets/custom_button.dart';

// enum টি কন্ট্রোলার ফাইলে নিয়ে যাওয়া হয়েছে

class BookAppointmentScreen extends StatefulWidget {
  final Map<String, dynamic> doctor;
  const BookAppointmentScreen({super.key, required this.doctor});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {

  final AppointmentController _appointmentController = Get.put(AppointmentController());

  // Form validation
  final _formKey = GlobalKey<FormState>();

  // Input field controllers
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _noteController;

  // UI State
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  int? _selectedTimeIndex;
  PaymentOption _paymentOption = PaymentOption.payLater;
  bool _agreedToTerms = false;
  // bool _isProcessing = false; // এই স্টেট এখন কন্ট্রোলারে ম্যানেজ হবে

  // Static Data
  final List<String> _timeSlots = [
    "10:00 AM", "11:00 AM", "12:00 PM",
    "1:00 PM", "2:00 PM", "3:00 PM"
  ];
  final Map<int, String> _weekdayMap = {
    1: 'Monday', 2: 'Tuesday', 3: 'Wednesday', 4: 'Thursday',
    5: 'Friday', 6: 'Saturday', 7: 'Sunday',
  };
  late List<String> _availableWeekdays;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _noteController = TextEditingController();

    _availableWeekdays = List<String>.from(widget.doctor['available_days'] ?? []);
    _selectFirstAvailableDay();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _selectFirstAvailableDay() {
    DateTime dayToCheck = DateTime.now();
    for (int i = 0; i < 365; i++) {
      if (_isDayEnabled(dayToCheck)) {
        setState(() {
          _selectedDay = dayToCheck;
          _focusedDay = dayToCheck;
        });
        return;
      }
      dayToCheck = dayToCheck.add(const Duration(days: 1));
    }
  }

  bool _isDayEnabled(DateTime day) {
    final String? weekdayName = _weekdayMap[day.weekday];
    return weekdayName != null && _availableWeekdays.contains(weekdayName);
  }

  // Main booking logic টি এখন কন্ট্রোলারকে কল করবে
  Future<void> _handleBooking() async {
    // ফর্ম ভ্যালিড কি না তা চেক করা
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // কন্ট্রোলারের মেথড কল করা এবং UI থেকে সমস্ত প্রয়োজনীয় ডেটা পাস করা
    await _appointmentController.bookAppointment(
      selectedDay: _selectedDay,
      selectedTime: _selectedTimeIndex != null ? _timeSlots[_selectedTimeIndex!] : null,
      agreedToTerms: _agreedToTerms,
      paymentOption: _paymentOption,
      doctor: widget.doctor,
      patientName: _nameController.text,
      patientPhone: _phoneController.text,
      shortNote: _noteController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.secondary, size: 24.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Book Appointment', style: TextStyle(fontFamily: 'Poppins', fontSize: 18.sp, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.secondary)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              _DoctorInfoCard(doctor: widget.doctor),
              SizedBox(height: 30.h),
              _buildSectionTitle('Select Date'),
              SizedBox(height: 15.h),
              _buildCalendar(),
              SizedBox(height: 30.h),
              _buildSectionTitle('Select Time'),
              SizedBox(height: 15.h),
              _buildTimeSlots(),
              SizedBox(height: 30.h),
              _buildSectionTitle('Patient Details'),
              SizedBox(height: 15.h),
              _buildInputField(controller: _nameController, hintText: 'Patient Name', validator: (v) => v!.isEmpty ? 'Name is required' : null),
              SizedBox(height: 20.h),
              _buildInputField(controller: _phoneController, hintText: 'Patient Phone', keyboardType: TextInputType.phone, validator: (v) => v!.isEmpty ? 'Phone is required' : null),
              SizedBox(height: 20.h),
              _buildInputField(controller: _noteController, hintText: 'Short note or reason (optional)', maxLines: 4),
              SizedBox(height: 30.h),
              _buildSectionTitle('Payment Method'),
              _buildPaymentOptions(),
              SizedBox(height: 20.h),
              _buildTermsAndConditions(),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: SizedBox(
          width: double.infinity,
          // Obx দিয়ে বাটনটি র‍্যাপ করা হয়েছে যাতে isProcessing স্টেট পরিবর্তন হলে বাটনটি রি-বিল্ড হয়
          child: Obx(() => CustomButton(
            text: _appointmentController.isProcessing.value ? 'Processing...' : 'Book Appointment',
            onPressed: _appointmentController.isProcessing.value ? null : _handleBooking,
          )),
        ),
      ),
    );
  }

  // --- বাকি উইজেট বিল্ডার মেথডগুলো অপরিবর্তিত থাকবে ---

  Widget _buildPaymentOptions() {
    return Column(
      children: [
        RadioListTile<PaymentOption>(
          title: Text('Pay Now', style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
          value: PaymentOption.payNow,
          groupValue: _paymentOption,
          onChanged: (PaymentOption? value) => setState(() => _paymentOption = value!),
          activeColor: Theme.of(context).colorScheme.surface,
          contentPadding: EdgeInsets.zero,
        ),
        RadioListTile<PaymentOption>(
          title: Text('Pay Later', style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
          value: PaymentOption.payLater,
          groupValue: _paymentOption,
          onChanged: (PaymentOption? value) => setState(() => _paymentOption = value!),
          activeColor: Theme.of(context).colorScheme.surface,
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontFamily: 'Poppins', color: Theme.of(context).colorScheme.onPrimary, fontSize: 15.sp),
        filled: true,
        fillColor: Theme.of(context).colorScheme.primary,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      ),
    );
  }

  Widget _buildSectionTitle(String title) { return Text(title, style: TextStyle(fontFamily: 'Poppins', fontSize: 18.sp, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.secondary)); }
  Widget _buildCalendar() { return Container(decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, borderRadius: BorderRadius.circular(12.r)), child: TableCalendar(focusedDay: _focusedDay, firstDay: DateTime.now(), lastDay: DateTime.utc(2030, 12, 31), selectedDayPredicate: (day) => isSameDay(_selectedDay, day), enabledDayPredicate: _isDayEnabled, onDaySelected: (selectedDay, focusedDay) { setState(() { _selectedDay = selectedDay; _focusedDay = focusedDay; }); }, headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true, titleTextStyle: TextStyle(fontFamily: 'Poppins', fontSize: 16.sp, fontWeight: FontWeight.w500), leftChevronIcon: Icon(Icons.chevron_left, color: Theme.of(context).colorScheme.secondary), rightChevronIcon: Icon(Icons.chevron_right, color: Theme.of(context).colorScheme.secondary)), calendarStyle: CalendarStyle(disabledTextStyle: TextStyle(color: Colors.grey.withOpacity(0.5)), defaultTextStyle: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp), weekendTextStyle: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp), todayDecoration: BoxDecoration(color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5), shape: BoxShape.circle), selectedDecoration: BoxDecoration(color: Theme.of(context).colorScheme.onPrimary, shape: BoxShape.circle), selectedTextStyle: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, color: Theme.of(context).colorScheme.background)), daysOfWeekStyle: DaysOfWeekStyle(weekdayStyle: TextStyle(fontFamily: 'Poppins', color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600), weekendStyle: TextStyle(fontFamily: 'Poppins', color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600)))); }
  Widget _buildTimeSlots() { return Wrap(spacing: 12.w, runSpacing: 12.h, children: List.generate(_timeSlots.length, (index) { bool isSelected = _selectedTimeIndex == index; return GestureDetector(onTap: () => setState(() => _selectedTimeIndex = index), child: Container(padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w), decoration: BoxDecoration(color: isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(10.r)), child: Text(_timeSlots[index], style: TextStyle(fontFamily: 'Poppins', fontSize: 14.sp, fontWeight: FontWeight.w500, color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onPrimary)))); })); }
  Widget _buildTermsAndConditions() { return Row(children: [SizedBox(width: 24.w, height: 24.h, child: Checkbox(value: _agreedToTerms, onChanged: (bool? value) => setState(() => _agreedToTerms = value ?? false), activeColor: Theme.of(context).colorScheme.surface)), SizedBox(width: 12.w), Expanded(child: Text('I agree to the Terms of Service and Privacy Policy', style: TextStyle(fontSize: 14.sp, color: Theme.of(context).colorScheme.secondary)))]); }
}

class _DoctorInfoCard extends StatelessWidget {
  final Map<String, dynamic> doctor;
  const _DoctorInfoCard({required this.doctor});
  @override
  Widget build(BuildContext context) { final String name = doctor['name'] ?? 'N/A'; final String specialty = doctor['specialty'] ?? 'N/A'; final String? imageUrl = doctor['image_url']; return Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: TextStyle(fontFamily: 'Poppins', fontSize: 22.sp, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary), maxLines: 2, overflow: TextOverflow.ellipsis), SizedBox(height: 5.h), Text(specialty, style: TextStyle(fontFamily: 'Poppins', fontSize: 16.sp, color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.w500))])), SizedBox(width: 16.w), SizedBox(width: 80.w, height: 80.h, child: ClipRRect(borderRadius: BorderRadius.circular(12.r), child: (imageUrl != null && imageUrl.isNotEmpty) ? Image.network(imageUrl, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Image.asset('assets/img/splash-icon.png', fit: BoxFit.cover)) : Image.asset('assets/img/splash-icon.png', fit: BoxFit.cover)))]); }
}