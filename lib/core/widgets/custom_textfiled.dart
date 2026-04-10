import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_project/core/constants/app_constants.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    this.title,
    required this.icon,
    required this.inputType,
    required this.label,
    required this.controller,
    required this.obscureText,
    this.inputFormatters,
    this.validator,
    this.onSubmitted,
  });

  final String? title;
  final Icon icon;
  final TextInputType? inputType;
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final FormFieldValidator? validator;
  final ValueChanged<String>? onSubmitted;

  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Text(
              title ?? '',
              style: TextStyle(
                color: AppColors.KPrimaryColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            onFieldSubmitted: onSubmitted,
            controller: controller,
            validator: validator,
            inputFormatters: inputFormatters,
            obscureText: obscureText,
            keyboardType: inputType,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.KWhiteColor,
              contentPadding: EdgeInsets.symmetric(
                vertical: 8.h,
                horizontal: 12.w,
              ),
              prefixIcon: Icon(icon.icon, color: Colors.grey),
              label: Text(label),
              labelStyle: TextStyle(color: AppColors.KgreyColor),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColors.KPrimaryColor),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColors.KPrimaryColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColors.KPrimaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColors.KPrimaryColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: AppColors.KPrimaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
