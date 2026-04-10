import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/di/setup_services.dart';
import 'package:fuji_maintenance_system/core/service/localization_service/language.dart';
import 'package:fuji_maintenance_system/core/service/localization_service/localization_service.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:get/get.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.7,
      child: Switch(
        hoverColor: AppColor.primaryDark,
        inactiveThumbColor: AppColor.secondary,
        activeTrackColor: AppColor.secondary,
        thumbColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.selected)) {
            return AppColor.white;
          }
          return AppColor.secondary;
        }),
        value: Get.locale?.languageCode == 'en',
        onChanged: (value) {
          getIt<LocaleService>().changeLocale(
            value ? Language.english : Language.arabic,
          );
        },
      ),
    );
  }
}
