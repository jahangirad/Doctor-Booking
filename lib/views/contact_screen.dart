import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/info_card.dart';



class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

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
          'Contact',
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
              InfoCard(
                icon: Icons.phone_in_talk_outlined,
                title: 'Phone',
                subtitle: '01796-196500',
              ),
              SizedBox(height: 24.h),
              InfoCard(
                icon: Icons.email_outlined,
                title: 'Email',
                subtitle: 'jahangirad14@gmail.com',
              ),
              SizedBox(height: 24.h),
              InfoCard(
                icon: Icons.online_prediction,
                title: 'WhatsApp',
                subtitle: 'Chat with us',
              ),
            ],
          ),
        ),
      ),
    );
  }
}