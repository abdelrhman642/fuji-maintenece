import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/di/setup_services.dart';
import 'package:fuji_maintenance_system/core/service/webservice/api_service.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/home/data/repositories/admin_home_repo.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/home/presentation/cubit/home_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/home/presentation/cubit/home_state.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/home/presentation/widgets/custom_drawer.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/home/presentation/widgets/home_body.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/home/presentation/widgets/home_error_widget.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/home/presentation/widgets/home_loading_widget.dart';
import 'package:fuji_maintenance_system/core/routing/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create:
          (_) =>
              HomeCubit(AdminHomeRepoImpl(getIt<ApiService>()))..loadHomeData(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();

          return Scaffold(
            backgroundColor: AppColor.background,
            appBar: AppBar(
              title: Text(AppStrings.home.tr, style: AppFont.font16W700Black),
              centerTitle: true,
              backgroundColor: AppColor.transparent,
              leading: Builder(
                builder: (context) {
                  return IconButton(
                    icon: Icon(Icons.menu, color: AppColor.black),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  );
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.notifications_on_outlined,
                    color: AppColor.black,
                  ),
                  onPressed: () => context.push(Routes.notificationsScreen),
                  tooltip: AppStrings.notifications.tr,
                ),
                IconButton(
                  icon: Icon(Icons.refresh, color: AppColor.black),
                  onPressed: () => cubit.refreshData(),
                ),
                // const UserProfileDropdown(),
              ],
            ),
            drawer: CustomDrawer(),
            body: () {
              if (state is HomeLoadingState) {
                return const HomeLoadingWidget();
              } else if (state is HomeErrorState) {
                return HomeErrorWidget(
                  message: state.message,
                  onRetry: () => cubit.loadHomeData(),
                );
              } else if (state is HomeLoadedState) {
                return HomeBody(
                  statistics: state.statistics,
                  chartData: state.chartData,
                  selectedChartType: state.selectedChartType,
                  onChartTypeChanged: (type) => cubit.selectChartType(type),
                  visitsProgress: state.visitsProgress,
                  reportsProgress: state.reportsProgress,
                  chartLabels: state.chartLabels,
                );
              }

              // Initial or unknown state - show loading
              return const HomeLoadingWidget();
            }(),
          );
        },
      ),
    );
  }
}
