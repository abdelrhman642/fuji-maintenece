import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/shared/features/auth/presentation/widgets/custom_auth_appbar.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routing/routes.dart';
import '../../../../../core/theme/app_font.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../interfaces/client/features/guest_mode/guest_mode.dart';
import '../controllers/login_controller.dart';
import '../widgets/custom_filled_button.dart';

class LoginView extends ConsumerStatefulWidget {
  final String? userType;

  const LoginView({super.key, this.userType});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAuthAppBar(),
              SizedBox(height: 25.h),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'welcome'.tr,
                  style: AppFont.font20W700Black.copyWith(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: 25.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Phone field
                      Text(
                        'phone_number'.tr,
                        style: AppFont.font14W600Black.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        controller: _phoneController,
                        hintText: 'enter_phone_number'.tr,
                        prefixIcon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please_enter_phone_number'.tr;
                          }
                          if (!GetUtils.isPhoneNumber(value)) {
                            return 'please_enter_a_valid_phone_number'.tr;
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 24.h),

                      // Password field
                      Text(
                        'password'.tr,
                        style: AppFont.font14W600Black.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: 'enter_password'.tr,
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
                            return 'please_enter_your_password'.tr;
                          }
                          if (value.length < 6) {
                            return 'password_must_be_at_least_6_characters_long'
                                .tr
                                .tr;
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 16.h),

                      // Register link for technicians
                      if (widget.userType == 'technician')
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'no_account'.tr,
                              style: AppFont.font14W500Grey2.copyWith(
                                fontSize: 14.sp,
                                color: AppColor.blackColor,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.push(
                                  '${Routes.register}?userType=${widget.userType}',
                                );
                              },
                              child: Text(
                                'register_here'.tr,
                                style: AppFont.font14W500Grey2.copyWith(
                                  fontSize: 14.sp,
                                  color: AppColor.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                      // Forgot password link
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // TODO: Navigate to forgot password screen
                            Get.snackbar(
                              'قريبا',
                              'سيتم إضافة هذه الميزة قريبا',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          },
                          child: Text(
                            'forgot_your_password'.tr,
                            style: AppFont.font14W500Grey2.copyWith(
                              fontSize: 14.sp,
                              color: AppColor.grey2,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // Login button
                      CustomFilledButton(
                        text: 'login'.tr,
                        color: AppColor.primary,
                        isLoading: _isLoading,
                        onPressed: _handleLogin,
                        height: 56.h,
                      ),

                      // Guest Mode button (only for clients)
                      if (widget.userType == 'client') ...[
                        SizedBox(height: 16.h),
                        OutlinedButton(
                          onPressed: () {
                            GuestModeProvider.enableGuestMode();
                            context.go(Routes.customerScreen);
                            Get.snackbar(
                              'وضع الضيف'.tr,
                              'تم الدخول كضيف. يمكنك تصفح البيانات التجريبية',
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: AppColor.primary.withOpacity(
                                0.8,
                              ),
                              colorText: Colors.white,
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            minimumSize: Size(double.infinity, 56.h),
                            side: BorderSide(color: AppColor.primary, width: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.preview_outlined,
                                color: AppColor.primary,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                AppStrings.browseAsGuest.tr,
                                style: AppFont.font16W600Black.copyWith(
                                  color: AppColor.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

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

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (widget.userType == null || widget.userType!.isEmpty) {
      Get.snackbar(
        'error'.tr,
        'Please select account type first',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColor.error,
        colorText: Colors.white,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Get the login controller
      final loginController = ref.read(loginControllerProvider.notifier);

      // Attempt login
      final success = await loginController.login(
        phone: _phoneController.text.trim(),
        password: _passwordController.text,
        userType: widget.userType!,
        context: context,
      );

      // Check if widget is still mounted before using context
      if (!mounted) return;

      if (success == true) {
        // Show success message
        Get.snackbar(
          'login_successful'.tr,
          'welcome_to_fuji_maintenance_system'.tr,
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColor.success,
          colorText: Colors.white,
        );

        // Get the actual user type from the login response
        final loginState = ref.read(loginControllerProvider);
        final actualUserType = loginState.userType ?? widget.userType!;

        // Navigate based on actual user type from API
        switch (actualUserType) {
          case 'admin':
            context.go(Routes.home);
            break;
          case 'technician':
            context.go(Routes.technicianScreen);
            break;
          case 'client':
            context.go(Routes.customerScreen);
            break;
          default:
            context.go(Routes.accountTypeSelection);
        }
      } else if (success == null) {
        // Account not activated case
        context.push(Routes.accountNotActivatedScreen);
      } else {
        // Get error message from state
        final state = ref.read(loginControllerProvider);
        final errorMessage = state.errorMessage ?? 'login_failed'.tr;

        Get.snackbar(
          'error'.tr,
          errorMessage,
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColor.error,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'an_unexpected_error_occurred'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColor.error,
        colorText: Colors.white,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
