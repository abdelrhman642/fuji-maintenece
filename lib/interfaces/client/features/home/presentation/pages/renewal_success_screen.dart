import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class RenewalSuccessScreen extends StatelessWidget {
  const RenewalSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6F3),
      body: SafeArea(
        child: Stack(
          children: [
            // Top ribbon
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 60,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3C12C),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            // Card content
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Circular check icon
                    Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF3C12C),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      AppStrings.success.tr,
                      style: AppFont.font20W700Black.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      AppStrings.orderProcessedSuccessfully.tr,
                      style: AppFont.font14W500Grey2.copyWith(
                        fontSize: 14,
                        color: const Color(0xFF808080),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            // Bottom button
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      AppStrings.back.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
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
