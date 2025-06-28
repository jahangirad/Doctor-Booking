import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';



class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.secondary, size: 24.sp),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Reusable Input Fields
              CustomTextField(hintText: 'Name', controller: name,),
              SizedBox(height: 24.h),
              CustomTextField(hintText: 'Email', controller: email,),
              SizedBox(height: 24.h),
              CustomTextField(hintText: 'Phone Number', controller: phone,),

              // Spacer to push the button to the bottom
              const Spacer(),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: 'Submit',
                  onPressed: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=> const MainScreen()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}