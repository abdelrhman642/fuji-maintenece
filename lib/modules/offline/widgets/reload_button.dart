import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_font.dart';

class ReloadButton extends StatefulWidget {
  const ReloadButton({super.key});

  @override
  State<ReloadButton> createState() => _ReloadButtonState();
}

class _ReloadButtonState extends State<ReloadButton> {
  bool _isLoading = false;

  Future<void> _checkConnection() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      await Future.delayed(
        const Duration(seconds: 2),
      ); // Give time for animation

      if (connectivityResult != ConnectivityResult.none) {
        Get.snackbar(
          'success'.tr,
          'Internet connection restored!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColor.success,
          colorText: Colors.white,
          icon: const Icon(Icons.check_circle, color: Colors.white),
        );
      } else {
        Get.snackbar(
          'warning'.tr,
          'Still no internet connection. Please check your network settings.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColor.warning,
          colorText: Colors.white,
          icon: const Icon(Icons.warning, color: Colors.white),
        );
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'Failed to check connection. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColor.error,
        colorText: Colors.white,
        icon: const Icon(Icons.error, color: Colors.white),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _checkConnection,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primary,
          disabledBackgroundColor: AppColor.disabled,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child:
            _isLoading
                ? SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: const CustomLoadingIndicator(color: Colors.white),
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.refresh, color: Colors.white, size: 20.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'try_again'.tr,
                      style: AppFont.font16W600Primary.copyWith(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
