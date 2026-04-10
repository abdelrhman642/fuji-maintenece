import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuji_maintenance_system/core/extensions/async_value_ui.dart';
import 'package:fuji_maintenance_system/core/routing/routes.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/modules/splash/widgets/error_widget.dart';
import 'package:fuji_maintenance_system/modules/splash/widgets/logo_widget.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../core/service/local_data_service/local_data_manager.dart';
import '../../../core/service/local_data_service/local_data_manager_key.dart';
import '../controllers/splash_controller.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    final provider = ref.watch(splashProvider);
    ref.listen(splashProvider, (previous, next) async {
      if (previous?.hasValue == false && next.hasValue) {
        switch (next.value!) {
          case SplashNavigate.home:
            // Navigate to appropriate dashboard based on user role
            final dataManager = LocalDataManager.instance;
            final userRole = await dataManager.readString(
              LocalDataManagerKey.userRole,
            );
            if (userRole == 'admin') {
              if (mounted) context.go(Routes.home);
            } else if (userRole == 'technician') {
              if (mounted) context.go(Routes.technicianScreen);
            } else if (userRole == 'client') {
              if (mounted) context.go(Routes.customerScreen);
            } else {
              if (mounted) context.go(Routes.accountTypeSelection);
            }
            break;
          case SplashNavigate.accountTypeSelection:
            context.go(Routes.accountTypeSelection);
            break;
          case SplashNavigate.login:
            context.go(Routes.login);
            break;
        }
      }
    });
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          final isUpdateAvailable = ref.watch(isUpdateAvailableProvider);
          if (isUpdateAvailable) {
            return Text(
              "${'loading_some_updates'.tr} ...",
              style: AppFont.font16W600Gray2,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      body: provider.customWhen(
        refreshable: () => () => ref.refresh(splashProvider.future),
        ref: ref,
        data: (data) {
          return const Center(child: LogoWidget());
        },
        error: (o, b) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LogoWidget(),
              CustomErrorWidget(
                error: o,
                stackTrace: b,
                onRetry: () {
                  return ref.refresh(splashProvider.future);
                },
              ),
            ],
          );
        },
        loading:
            () => ScaleTransition(
              scale: _animation,
              child: const Center(child: LogoWidget()),
            ),
      ),
    );
  }
}
