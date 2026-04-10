import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/routing/routes.dart';
import 'package:fuji_maintenance_system/shared/features/auth/presentation/widgets/custom_auth_appbar.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_font.dart';
import '../widgets/custom_filled_button.dart';

/// Account type selection screen for choosing user role
class AccountTypeSelectionView extends StatefulWidget {
  const AccountTypeSelectionView({super.key});

  @override
  State<AccountTypeSelectionView> createState() =>
      _AccountTypeSelectionViewState();
}

class _AccountTypeSelectionViewState extends State<AccountTypeSelectionView>
    with SingleTickerProviderStateMixin {
  String? selectedUserType;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    responsiveInit(context);
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // Header with logo and curved background - Fixed (not scrollable)
            const CustomAuthAppBar(showBackButton: false),

            // Content section - Scrollable if needed
            Expanded(child: SingleChildScrollView(child: _buildContent())),
          ],
        ),
      ),
    );
  }

  // Remove the unused _buildHeader method as suggested.

  Widget _buildContent() {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: EdgeInsets.only(
            left: 24.w,
            right: 24.w,
            top: 20.h,
            bottom: 12.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Welcome message
              Text(
                'select_your_account_type'.tr,
                style: AppFont.font20W700Black.copyWith(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primary,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 4.h),

              Text(
                'select_the_account_type_to_access_the_system'.tr,
                style: AppFont.font16W500Black.copyWith(
                  fontSize: 13.sp,
                  color: AppColor.grey2,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 18.h),

              // User type selection cards
              _buildUserTypeCard(
                userType: 'admin',
                title: 'admin'.tr,
                subtitle: 'system_and_user_administration'.tr,
                icon: Icons.admin_panel_settings,
                color: AppColor.primaryLighter,
              ),
              SizedBox(height: 4.h),
              _buildUserTypeCard(
                userType: 'technician',
                title: 'technician'.tr,
                subtitle: 'carrying_out_maintenance_work'.tr,
                icon: Icons.engineering,
                color: AppColor.primaryLighter,
              ),
              SizedBox(height: 4.h),
              _buildUserTypeCard(
                userType: 'client',
                title: 'client'.tr,
                subtitle: 'request_maintenance_services'.tr,
                icon: Icons.person,
                color: AppColor.primaryLighter,
              ),

              SizedBox(height: 18.h),

              // Continue button
              CustomFilledButton(
                text: 'continuation'.tr,
                onPressed: selectedUserType != null ? _handleContinue : null,
                isValid: selectedUserType != null,
                ignorePressOnNotValid: true,
                height: 50.h,
                color: AppColor.primary,
                borderRadius: 16.r,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserTypeCard({
    required String userType,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    final isSelected = selectedUserType == userType;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedUserType = userType;
          });
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: isSelected ? color.withValues(alpha: 0.1) : Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isSelected ? color : AppColor.grey_3,
              width: isSelected ? 2.w : 1.w,
            ),
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: color.withValues(alpha: 0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Radio button
              Container(
                width: 24.w,
                height: 24.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? color : AppColor.grey2,
                    width: 2.w,
                  ),
                  color: isSelected ? color : Colors.transparent,
                ),
                child:
                    isSelected
                        ? Icon(Icons.check, size: 16.sp, color: Colors.white)
                        : null,
              ),

              SizedBox(width: 16.w),

              // Icon
              Container(
                width: 65.w,
                height: 65.h,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(icon, size: 32.sp, color: color),
              ),

              SizedBox(width: 16.w),

              // Text content - on same row as icon
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: AppFont.font16W700Black.copyWith(
                        fontSize: 19.sp,
                        color: isSelected ? color : AppColor.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: AppFont.font14W500Grey2.copyWith(
                        fontSize: 15.sp,
                        color: AppColor.grey2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleContinue() {
    if (selectedUserType != null) {
      // Navigate to login screen with selected user type
      context.push('${Routes.login}?userType=$selectedUserType');
    }
  }
}
