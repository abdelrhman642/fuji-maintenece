import 'package:flutter/material.dart';

import '../../../core/theme/app_font.dart';

class CustomErrorWidget extends StatelessWidget {
  final Object error;
  final StackTrace? stackTrace;
  final VoidCallback? onRetry;
  final String? title;
  final String? message;

  const CustomErrorWidget({
    super.key,
    required this.error,
    this.stackTrace,
    this.onRetry,
    this.title,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 64.r, color: Colors.red),

          SizedBox(height: 16.h),

          Text(
            title ?? 'حدث خطأ',
            style: AppFont.font20W700Black.copyWith(color: Colors.red),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 8.h),

          Text(
            message ?? _getErrorMessage(error),
            style: AppFont.font14W500Black.copyWith(color: AppColor.grey2),
            textAlign: TextAlign.center,
          ),

          if (onRetry != null) ...[
            SizedBox(height: 24.h),

            ElevatedButton.icon(
              onPressed: onRetry,
              icon: Icon(Icons.refresh, size: 20.r),
              label: const Text('إعادة المحاولة'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getErrorMessage(Object error) {
    if (error.toString().contains('SocketException') ||
        error.toString().contains('HttpException')) {
      return 'تحقق من الاتصال بالإنترنت';
    } else if (error.toString().contains('TimeoutException')) {
      return 'انتهت مهلة الاتصال';
    } else if (error.toString().contains('FormatException')) {
      return 'خطأ في تنسيق البيانات';
    } else {
      return 'حدث خطأ غير متوقع';
    }
  }
}
