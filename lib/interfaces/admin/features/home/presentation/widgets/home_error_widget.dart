import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';

class HomeErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const HomeErrorWidget({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: AppColor.primary),
            const SizedBox(height: 16),
            Text(
              'Oops! Something went wrong',
              style: AppFont.font20W600Black,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(color: AppColor.lightGrey, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            if (onRetry != null)
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: Icon(Icons.refresh, color: AppColor.white),
                label: Text(
                  'Try Again',
                  style: TextStyle(color: AppColor.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
