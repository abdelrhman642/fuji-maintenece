import 'dart:ui';

import 'package:get/get.dart';

import '../local_data_service/local_data_manager.dart';
import 'language.dart';

class LocaleService {
  final LocalDataManager dataManager;

  LocaleService(this.dataManager);

  Locale get handleLocaleInMain {
    return getLocale().locale;
  }

  Language getLocale() {
    return dataManager.getLanguage ?? defaultLanguage;
  }

  Future<void> changeLocale(Language language) async {
    Get.updateLocale(language.locale);
    await dataManager.setLanguage(language);
  }

  Future<void> toggleLocale() async {
    if (!isArabic) {
      changeLocale(Language.arabic);
    } else {
      changeLocale(Language.english);
    }
  }

  Locale get defaultLocale => defaultLanguage.locale;

  Language get defaultLanguage => Language.arabic;

  bool get isArabic => Get.locale == Language.arabic.locale;
}
