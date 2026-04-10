import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuji_maintenance_system/core/di/setup_services.dart';
import 'package:get/get.dart';

import 'core/helper/responsive.dart';
import 'core/helper/riverpod.dart';
import 'core/routing/go_router.dart';
import 'core/service/localization_service/language.dart';
import 'core/service/localization_service/localization_service.dart';
import 'core/theme/app_theme.dart';
import 'core/translation/app_strings.dart';
import 'core/translation/app_translation.dart';
import 'modules/offline/no_wifi.dart';

/// Main application widget with routing and theming
class FujiMaintenanceApp extends ConsumerWidget {
  const FujiMaintenanceApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    responsiveInit(context);
    return ScreenUtilInit(
      fontSizeResolver: FontSizeResolvers.height,
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(375, 812),
      builder: (context, child) {
        return GetMaterialApp.router(
          // Routing
          routerDelegate: simpleRouter.routerDelegate,
          routeInformationParser: simpleRouter.routeInformationParser,
          routeInformationProvider: simpleRouter.routeInformationProvider,

          // Localization
          translations: Translation(),
          locale: getIt<LocaleService>().handleLocaleInMain,
          fallbackLocale: const Locale('ar', 'SA'),
          supportedLocales: Language.values.map((e) => e.locale).toList(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          // Theme
          theme: getLightTheme(),
          // darkTheme: getDarkTheme(),

          // App configuration
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,

          // Custom builder for RTL support and connectivity
          builder: _appBuilder,
        );
      },
    );
  }

  /// Custom app builder for RTL support and connectivity checking
  Widget _appBuilder(BuildContext context, Widget? widget) {
    return GestureDetector(
      // Dismiss keyboard when tapping outside
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
        child: Consumer(
          child: widget,
          builder: (context, ref, child) {
            final hasConnection = ref.watch(fuckInternetOk);
            return IndexedStack(
              index: hasConnection ? 0 : 1,
              children: [child!, const NoWifi()],
            );
          },
        ),
      ),
    );
  }
}
