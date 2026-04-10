import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/di/setup_services.dart';
import 'package:fuji_maintenance_system/core/errors/failure.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/routing/routes.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/shared/features/auth/presentation/controllers/auth_service.dart';
import 'package:fuji_maintenance_system/shared/features/auth/presentation/widgets/custom_auth_appbar.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_font.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../widgets/custom_filled_button.dart';

class RegisterView extends StatefulWidget {
  final String? userType;

  const RegisterView({super.key, this.userType});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String get _getUserTypeDisplayName {
    switch (widget.userType) {
      case AppStrings.technician:
        return AppStrings.technician.tr;
      case AppStrings.client:
        return AppStrings.client.tr;
      case AppStrings.admin:
        return AppStrings.admin.tr;
      default:
        return 'User'.tr;
    }
  }

  IconData get _getUserTypeIcon {
    switch (widget.userType) {
      case AppStrings.technician:
        return Icons.build;
      case AppStrings.client:
        return Icons.person;
      case AppStrings.admin:
        return Icons.admin_panel_settings;
      default:
        return Icons.account_circle;
    }
  }

  Color get _getUserTypeColor {
    switch (widget.userType) {
      case AppStrings.technician:
        return AppColor.primary;
      case AppStrings.client:
        return AppColor.userColor;
      case AppStrings.admin:
        return AppColor.adminColor;
      default:
        return AppColor.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Don't show register for admin
    if (widget.userType == 'admin') {
      return Scaffold(
        backgroundColor: AppColor.backGround,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.block, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                AppStrings.registrationNotAvailableForAdmins.tr,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColor.grey3,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                AppStrings.pleaseContactSystemDeveloper.tr,
                style: TextStyle(color: Colors.grey[500]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed:
                    () => context.go('/login?userType=${widget.userType}'),
                child: Text(AppStrings.backToLogin.tr),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: CustomAuthAppBar(),
      backgroundColor: AppColor.white,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getUserTypeIcon,
                          color: _getUserTypeColor,
                          size: 32.sp,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          AppStrings.createAccount.tr,
                          style: AppFont.font20W700Black.copyWith(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      _getUserTypeDisplayName,
                      style: AppFont.font14W500Grey2.copyWith(
                        fontSize: 16.sp,
                        color: _getUserTypeColor,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40.h),

              // Registration form
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'full_name'.tr,
                        style: AppFont.font14W600Black.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        controller: _fullNameController,
                        hintText: AppStrings.pleaseEnterYourFullName.tr,
                        prefixIcon: Icons.person_outline,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.pleaseEnterYourFullName.tr;
                          }
                          if (value.length < 3) {
                            return AppStrings.mustBeAtLeast3CharactersLong.tr;
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 24.h),

                      // Email field
                      Text(
                        'email'.tr,
                        style: AppFont.font14W600Black.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        controller: _emailController,
                        hintText: 'email'.tr,
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.pleaseEnterAnEmail.tr;
                          }
                          if (!GetUtils.isEmail(value)) {
                            return AppStrings.pleaseEnterAValidEmail.tr;
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 24.h),

                      // Phone field
                      Text(
                        AppStrings.phoneNumber.tr,
                        style: AppFont.font14W600Black.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        controller: _phoneController,
                        hintText: AppStrings.phoneNumber.tr,
                        prefixIcon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.pleaseEnterYourPhoneNumber.tr;
                          }
                          if (value.length < 10) {
                            return AppStrings.phoneNumberMustBe10DigitsLong.tr;
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 24.h),

                      // Password field
                      Text(
                        AppStrings.password.tr,
                        style: AppFont.font14W600Black.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: AppStrings.password.tr,
                        prefixIcon: Icons.lock_outline,
                        obscureText: _obscurePassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppColor.grey2,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.pleaseEnterYourPassword.tr;
                          }
                          if (value.length < 6) {
                            return AppStrings
                                .passwordMustBeAtLeast6CharactersLong
                                .tr;
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 24.h),

                      // Confirm Password field
                      Text(
                        AppStrings.confirmPassword.tr,
                        style: AppFont.font14W600Black.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        controller: _confirmPasswordController,
                        hintText: AppStrings.confirmPassword.tr,
                        prefixIcon: Icons.lock_outline,
                        obscureText: _obscureConfirmPassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppColor.grey2,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.pleaseConfirmYourPassword.tr;
                          }
                          if (value != _passwordController.text) {
                            return AppStrings.passwordsDoNotMatch.tr;
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 32.h),

                      // Register button
                      CustomFilledButton(
                        text: AppStrings.createAccount.tr,
                        color: _getUserTypeColor,
                        isLoading: _isLoading,
                        onPressed: () => _handleRegister(context),
                        height: 56.h,
                      ),

                      SizedBox(height: 24.h),

                      // Login link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.alreadyHaveAnAccount.tr,
                            style: AppFont.font14W500Grey2.copyWith(
                              fontSize: 14.sp,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.go('/login?userType=${widget.userType}');
                            },
                            child: Text(
                              AppStrings.loginHere.tr,
                              style: AppFont.font14W600Black.copyWith(
                                fontSize: 14.sp,
                                color: _getUserTypeColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleRegister(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final res = await getIt<AuthService>().registerTechnician(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      name: _fullNameController.text.trim(),
      phone: _phoneController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    res.fold(
      (l) {
        if (l is AccountNotActivatedFailure) {}
        context.showError(l.message);
        if (l is AccountNotActivatedFailure) {
          context.push(Routes.accountNotActivatedScreen);
        }
      },
      (r) {
        Get.snackbar(
          AppStrings.accountCreationSuccessful.tr,
          AppStrings.accountCreationSuccessfulMessage.tr,
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColor.success,
          colorText: AppColor.white,
        );
        context.go('/login?userType=${widget.userType}');
      },
    );

    // Navigate to login screen after successful registration
  }
}
