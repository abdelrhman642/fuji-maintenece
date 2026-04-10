import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/core/constants/app_constants.dart';
import 'package:flutter_project/features/auth/presentation/providers/login_provider.dart';
import 'package:flutter_project/features/auth/presentation/screens/register_view.dart';
import 'package:flutter_project/features/home/presentation/screens/home_view.dart';
import 'package:flutter_project/core/widgets/custom_textfiled.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);
    final formKey = GlobalKey<FormState>();
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();

    ref.listen<LoginState>(loginProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error!)));
      }
      if (!next.isLoading && previous!.isLoading && next.error == null) {
        context.go('/home');
      }
    });

    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: AppColors.KWhiteColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: double.infinity,
                    height: 362.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/image copy.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 362.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/image.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 47.w,
                              child: Divider(height: 1.h, color: Colors.white),
                            ),
                            Text(
                              'work ',
                              style: TextStyle(
                                height: 1.0.h,
                                fontSize: 64.sp,
                                color: AppColors.KWhiteColor,
                                fontFamily: 'ImperialScript',
                                decoration: TextDecoration.none,
                              ),
                            ),
                            SizedBox(
                              width: 47.w,
                              child: Divider(height: 1.h, color: Colors.white),
                            ),
                          ],
                        ),
                        Text(
                          'maintenance',
                          style: TextStyle(
                            height: .5.h,
                            fontSize: 32.sp,
                            color: AppColors.KWhiteColor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -80.h,
                    child: Container(
                      width: 173.r,
                      height: 173.r,
                      decoration: BoxDecoration(
                        color: AppColors.KWhiteColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.r,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Image.asset(
                          AppImages.KLogo,
                          width: 97.r,
                          height: 111.r,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 120.h),
              CustomTextField(
                controller: phoneController,
                validator:
                    (value) => value!.isEmpty ? 'Enter your Phone' : null,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                icon: Icon(Icons.phone),
                inputType: TextInputType.phone,
                title: 'phone number',
                label: 'phone number',

                obscureText: false,
              ),
              SizedBox(height: 16.h),

              CustomTextField(
                controller: passwordController,
                validator:
                    (value) =>
                        value!.length >= 8
                            ? null
                            : 'Password must be at least 8 characters',

                icon: Icon(Icons.remove_red_eye),
                title: 'password',
                inputType: TextInputType.visiblePassword,
                label: 'password',
                obscureText: true,
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.go('/register');
                    },
                    child: Text(
                      '  Sign UP',
                      style: TextStyle(
                        color: AppColors.KPrimaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.h),
              InkWell(
                onTap: () {
                  if (formKey.currentState?.validate() == true) {
                    ref
                        .read(loginProvider.notifier)
                        .login(phoneController.text, passwordController.text);
                  }
                },
                child: Center(
                  child: Container(
                    width: 358.w,
                    height: 46.h,
                    decoration: BoxDecoration(
                      color: AppColors.KPrimaryColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child:
                          loginState.isLoading
                              ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              )
                              : Text(
                                'login'.tr,
                                style: TextStyle(
                                  color: AppColors.KWhiteColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
