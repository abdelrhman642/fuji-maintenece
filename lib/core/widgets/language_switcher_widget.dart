import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/di/setup_services.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:get/get.dart';

import '../service/localization_service/language.dart';
import '../service/localization_service/localization_service.dart';
import '../theme/app_color.dart';

/// Language switcher widget with dropdown selection
class LanguageSwitcherWidget extends StatelessWidget {
  final bool isExpanded;
  final EdgeInsets? padding;

  const LanguageSwitcherWidget({
    super.key,
    this.isExpanded = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final localeService = getIt<LocaleService>();

    if (isExpanded) {
      return _buildExpandedLanguageSelector(context, localeService);
    } else {
      return _buildCompactLanguageSelector(context, localeService);
    }
  }

  /// Builds expanded language selector with flags and names
  Widget _buildExpandedLanguageSelector(
    BuildContext context,
    LocaleService localeService,
  ) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.grey3, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.language, color: AppColor.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                'language'.tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...Language.values.map(
            (language) => _buildLanguageOption(
              context,
              localeService,
              language,
              isSelected: localeService.getLocale() == language,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds compact language selector (dropdown)
  Widget _buildCompactLanguageSelector(
    BuildContext context,
    LocaleService localeService,
  ) {
    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.grey3, width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.language, color: AppColor.primary, size: 20),
          const SizedBox(width: 8),
          Text(
            'language'.tr,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.black,
            ),
          ),
          const Spacer(),
          DropdownButtonHideUnderline(
            child: DropdownButton<Language>(
              value: localeService.getLocale(),
              isDense: true,
              items:
                  Language.values.map((language) {
                    return DropdownMenuItem<Language>(
                      value: language,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            language.image, // Flag emoji
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            language.text,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColor.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
              onChanged: (Language? newLanguage) {
                if (newLanguage != null) {
                  _changeLanguage(context, localeService, newLanguage);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Builds individual language option for expanded view
  Widget _buildLanguageOption(
    BuildContext context,
    LocaleService localeService,
    Language language, {
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () => _changeLanguage(context, localeService, language),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColor.primary.withOpacity(0.1)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                isSelected ? AppColor.primary : AppColor.grey3.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                language.text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? AppColor.primary : AppColor.black,
                ),
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: AppColor.primary, size: 20),
          ],
        ),
      ),
    );
  }

  /// Changes the app language and updates UI
  void _changeLanguage(
    BuildContext context,
    LocaleService localeService,
    Language newLanguage,
  ) async {
    try {
      // Update language in local storage
      await localeService.changeLocale(newLanguage);
      // Show success message
      context.showSuccess('language_changed'.tr);
    } catch (e) {
      // Show error message
      context.showError('Failed to change language');
    }
  }
}

/// Language switcher dialog for quick language selection
class LanguageSwitcherDialog extends StatelessWidget {
  const LanguageSwitcherDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(Icons.language, color: AppColor.primary, size: 24),
                const SizedBox(width: 12),
                Text(
                  'select_language'.tr,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.black,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.close, color: AppColor.grey2, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const LanguageSwitcherWidget(isExpanded: true),
          ],
        ),
      ),
    );
  }

  /// Shows the language switcher dialog
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const LanguageSwitcherDialog(),
    );
  }
}
