import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../core/theme/app_font.dart';
import 'widgets/reload_button.dart';

class NoWifi extends StatelessWidget {
  const NoWifi({super.key});

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);

    return Scaffold(
      backgroundColor: AppColor.backGround,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // No WiFi Animation
                Lottie.asset(
                  'assets/base/no_wifi.json',
                  width: 200.w,
                  height: 200.h,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.wifi_off,
                      size: 120.sp,
                      color: AppColor.grey2,
                    );
                  },
                ),

                SizedBox(height: 32.h),

                // Title
                Text(
                  'network_error'.tr,
                  style: AppFont.font20W700Black.copyWith(fontSize: 24.sp),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 16.h),

                // Description
                Text(
                  'Please check your internet connection and try again.',
                  style: AppFont.font16W500Black.copyWith(
                    color: AppColor.grey2,
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 48.h),

                // Reload Button
                const ReloadButton(),

                SizedBox(height: 24.h),

                // Additional Tips
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColor.grey_3, width: 1),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.lightbulb_outline,
                            color: AppColor.warning,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text('Tips:', style: AppFont.font14W700Black),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      _buildTipItem('Check your WiFi connection'),
                      _buildTipItem('Try mobile data if available'),
                      _buildTipItem('Restart your router'),
                      _buildTipItem('Contact your network provider'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTipItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 8.h, right: 8.w),
            width: 4.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColor.grey2,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(child: Text(text, style: AppFont.font12w500Grey2)),
        ],
      ),
    );
  }
}
