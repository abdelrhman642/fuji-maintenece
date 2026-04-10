import 'package:flutter/material.dart';
import 'package:flutter_project/core/constants/app_constants.dart';
import 'package:flutter_project/core/widgets/custom_textfiled.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SentReportView extends ConsumerWidget {
  const SentReportView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.KWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.KWhiteColor,
        iconTheme: IconThemeData(color: AppColors.KPrimaryColor, size: 20),
        title: Text(
          'Sent Report',
          style: TextStyle(
            color: AppColors.KPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Center(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              padding: EdgeInsets.all(25),
              width: 345.w,
              height: 350.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromRGBO(0, 0, 0, 0.25),
                    offset: const Offset(4, 4),
                    blurRadius: 20,
                  ),
                ],
                color: AppColors.KWhiteColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    controller: emailController,
                    icon: Icon(Icons.email),
                    inputType: TextInputType.emailAddress,
                    label: 'enter this email',
                    obscureText: false,
                  ),

                  CustomTextField(
                    controller: phoneController,
                    icon: Icon(Icons.message_sharp),
                    inputType: TextInputType.emailAddress,
                    label: 'enter this phone',
                    obscureText: false,
                  ),
                ],
              ),
            ),
            Positioned(
              top: -85.h,
              child: Container(
                height: 185.h,
                width: 185.w,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.KPrimaryColor),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    height: 157.h,
                    width: 157.w,
                    decoration: BoxDecoration(
                      color: AppColors.KPrimaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check,
                        color: AppColors.KWhiteColor,
                        size: 120,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
