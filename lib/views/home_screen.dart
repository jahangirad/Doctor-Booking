import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/doctor_details_controller.dart'; // কন্ট্রোলারের পাথ
import '../widgets/doctor_card.dart';
import '../widgets/filter_button.dart';
import 'doctor_info_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Get the controller instance
  final DoctorDetailsController controller = Get.put(DoctorDetailsController());
  final TextEditingController _searchController = TextEditingController();

  int _selectedFilterIndex = 0;
  String _searchQuery = '';

  // specialty লিস্ট আমরা ডাটা থেকে ডায়নামিকভাবে তৈরি করতে পারি অথবা হার্ডকোডেড রাখতে পারি
  final List<String> filters = ["All", "Cardiologist", "Dermatologist", "Neurologist", "Pediatrician"]; // প্রয়োজনে আরও যোগ করুন

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        title: Text(
          'Find a doctor',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search by name, specialty, or clinic...',
                  hintStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 16.sp),
                  prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.onPrimary, size: 24.sp),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.primary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 45.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  itemBuilder: (context, index) {
                    return FilterButton(
                      text: filters[index],
                      isSelected: _selectedFilterIndex == index,
                      onTap: () {
                        setState(() {
                          _selectedFilterIndex = index;
                        });
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'All Doctors',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              SizedBox(height: 16.h),
              // Obx widget দিয়ে UI-কে reactive করা হয়েছে
              Obx(() {
                // Step 1: Filter by specialty
                List<Map<String, dynamic>> filteredList = controller.doctorList;
                if (_selectedFilterIndex != 0) {
                  final selectedSpecialty = filters[_selectedFilterIndex];
                  filteredList = controller.doctorList
                      .where((doctor) =>
                  (doctor['specialty'] as String?)?.toLowerCase() ==
                      selectedSpecialty.toLowerCase())
                      .toList();
                }

                // Step 2: Filter by search query
                List<Map<String, dynamic>> displayedDoctors = filteredList;
                if (_searchQuery.isNotEmpty) {
                  displayedDoctors = filteredList
                      .where((doctor) {
                    final name = (doctor['name'] as String? ?? '').toLowerCase();
                    final specialty = (doctor['specialty'] as String? ?? '').toLowerCase();
                    final clinic = (doctor['clinic_name'] as String? ?? '').toLowerCase();
                    final query = _searchQuery.toLowerCase();
                    return name.contains(query) ||
                        specialty.contains(query) ||
                        clinic.contains(query);
                  })
                      .toList();
                }

                if (controller.doctorList.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (displayedDoctors.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'No doctors found.',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ),
                  );
                }

                // এখানে শুধুমাত্র একটি ListView.builder ব্যবহার করা হয়েছে
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: displayedDoctors.length,
                  itemBuilder: (context, index) {
                    final doctor = displayedDoctors[index];

                    return DoctorCard(
                      name: doctor['name'] ?? 'No Name',
                      specialty: doctor['specialty'] ?? 'No Specialty',
                      address: doctor['address'] ?? 'No Address',
                      imageUrl: doctor['image_url'] ?? 'assets/img/splash-icon.png',
                      onViewProfile: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DoctorInfoScreen(doctor: doctor),
                          ),
                        );
                      },
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}