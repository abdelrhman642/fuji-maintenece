import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/di/setup_services.dart';
import 'package:fuji_maintenance_system/core/theme/app_font.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_app_bar_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/empty_data_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/client/features/guest_mode/guest_mode.dart';
import 'package:fuji_maintenance_system/interfaces/client/features/home/presentation/cubit/home_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/client/features/home/presentation/pages/renewal_screen.dart';
import 'package:fuji_maintenance_system/interfaces/client/features/home/presentation/widgets/contracts_tab_widget.dart';
import 'package:fuji_maintenance_system/interfaces/client/features/home/presentation/widgets/report_tab_widget.dart';
import 'package:fuji_maintenance_system/shared/features/auth/presentation/screens/settings_screen.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  int _currentIndex = 0;

  final List<String> _pageTitles = [
    AppStrings.contracts.tr,
    AppStrings.reports.tr,
    AppStrings.renewal.tr,
    AppStrings.profile.tr,
  ];

  @override
  Widget build(BuildContext context) {
    // Check if guest mode is enabled
    final isGuestMode = GuestModeProvider.isGuestMode;

    if (isGuestMode) {
      // Guest mode: show dummy data without BlocProvider
      return Scaffold(
        backgroundColor: AppColor.background,
        appBar: CustomAppBarWidget(
          textColor: AppColor.white,
          backgroundColor: AppColor.primaryDark,
          title: _pageTitles[_currentIndex],
        ),
        body: _buildGuestModeBody(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      );
    }

    // Normal mode: use BlocProvider
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..fetchAllData(),
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: CustomAppBarWidget(
          textColor: AppColor.white,
          backgroundColor: AppColor.primaryDark,
          // actions: _currentIndex != 3 ? [UserProfileDropdown()] : null,
          title: _pageTitles[_currentIndex],
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const CustomLoadingIndicator();
            } else if (state is HomeError) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(color: AppColor.error),
                ),
              );
            } else if (state is HomeLoaded) {
              final contracts = state.contracts;
              final reports = state.reports;

              return IndexedStack(
                index: _currentIndex,
                children: [
                  // Contracts Tab
                  if (contracts.isNotEmpty)
                    ContractsTab(contracts: contracts)
                  else
                    EmptyDataWidget(),

                  // Reports Tab
                  if (reports.isNotEmpty)
                    ReportTab(reports: reports)
                  else
                    EmptyDataWidget(),
                  // Renewal Screen
                  RenewalScreen(),
                  // Settings Screen (Profile)
                  const SettingsScreen(showAppBar: false),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  // Build bottom navigation bar
  Widget _buildBottomNavigationBar() {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColor.background,
        selectedItemColor: AppColor.primary,
        unselectedItemColor: AppColor.neutral,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        unselectedIconTheme: const IconThemeData(size: 24),
        selectedIconTheme: const IconThemeData(size: 28),
        unselectedLabelStyle: const TextStyle(fontSize: 14),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.description),
            activeIcon: const Icon(Icons.description),
            label: AppStrings.contracts.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.assessment),
            activeIcon: const Icon(Icons.assessment),
            label: AppStrings.reports.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.refresh),
            activeIcon: const Icon(Icons.refresh),
            label: AppStrings.renewal.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            activeIcon: const Icon(Icons.person),
            label: AppStrings.profile.tr,
          ),
        ],
      ),
    );
  }

  // Build guest mode body with dummy data
  Widget _buildGuestModeBody() {
    final dummyContracts = GuestModeProvider.getDummyContracts();
    final dummyReports = GuestModeProvider.getDummyReports();

    return Column(
      children: [
        // Guest Mode Banner
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: AppColor.primary.withOpacity(0.1),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: AppColor.primary, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'أنت تتصفح كضيف - البيانات المعروضة تجريبية',
                  style: AppFont.font14W500Grey2.copyWith(
                    color: AppColor.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  GuestModeProvider.showLoginRequiredDialog(context);
                },
                child: Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    color: AppColor.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Main content
        Expanded(
          child: IndexedStack(
            index: _currentIndex,
            children: [
              // Contracts Tab
              ContractsTab(contracts: dummyContracts),

              // Reports Tab
              ReportTab(reports: dummyReports),

              // Renewal Screen
              RenewalScreen(),

              // Settings Screen (Profile) - with guest mode notice
              _buildGuestProfileScreen(),
            ],
          ),
        ),
      ],
    );
  }

  // Build guest profile screen
  Widget _buildGuestProfileScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_off_outlined, size: 80, color: AppColor.grey2),
            SizedBox(height: 24),
            Text(
              'أنت في وضع الضيف',
              style: AppFont.font20W700Black.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'لعرض ملفك الشخصي والوصول لجميع الميزات، يرجى تسجيل الدخول',
              style: AppFont.font14W500Grey2.copyWith(
                fontSize: 16,
                color: AppColor.grey2,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                GuestModeProvider.showLoginRequiredDialog(context);
              },
              icon: Icon(Icons.login),
              label: Text('تسجيل الدخول'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
