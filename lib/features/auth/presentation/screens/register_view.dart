import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/core/constants/app_constants.dart';
import 'package:flutter_project/features/auth/presentation/providers/register_provider.dart';
import 'package:flutter_project/features/auth/presentation/screens/login_view.dart';
import 'package:flutter_project/features/home/presentation/screens/home_view.dart';
import 'package:flutter_project/core/widgets/custom_textfiled.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class RegisterView extends ConsumerWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerState = ref.watch(registerProvider);
    final formKey = GlobalKey<FormState>();
    final fullNameController = TextEditingController();
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final emailController = TextEditingController();
    final addressController = TextEditingController();

    ref.listen<RegisterState>(registerProvider, (previous, next) {
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
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    height: 186.h,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromRGBO(0, 0, 0, 0.25),
                          offset: const Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                      color: AppColors.KPrimaryColor,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 60.h),
                    alignment: Alignment.center,
                    child: Text(
                      'create_account'.tr,
                      style: TextStyle(
                        height: 1.0,
                        fontSize: 15.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 100.h),
                      width: 154.w,
                      height: 164.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22.r),
                        color: const Color.fromRGBO(255, 255, 255, 1),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22.r),
                          color: AppColors.KPrimaryColor,
                        ),
                        child: SizedBox(
                          height: 70,
                          width: 70,
                          child: Image.asset(
                            AppImages.profile,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              CustomTextField(
                controller: fullNameController,
                validator: (value) => value!.isEmpty ? 'enter your name' : null,
                icon: Icon(Icons.person),
                inputType: TextInputType.name,
                title: 'full name',
                label: 'enter your full name',
                obscureText: false,
              ),
              CustomTextField(
                controller: phoneController,
                validator:
                    (value) =>
                        value!.isEmpty ? 'enter your phone number' : null,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                icon: Icon(Icons.phone),
                inputType: TextInputType.phone,
                title: 'phone number',
                label: 'enter your phone number',
                obscureText: false,
              ),
              CustomTextField(
                controller: passwordController,
                validator:
                    (value) => value!.isEmpty ? 'enter your password' : null,
                icon: Icon(Icons.remove_red_eye),
                inputType: TextInputType.visiblePassword,
                title: 'password',
                label: 'enter your password',
                obscureText: true,
              ),
              CustomTextField(
                controller: confirmPasswordController,
                validator:
                    (value) => value!.isEmpty ? 'confirm your password' : null,
                icon: Icon(Icons.remove_red_eye),
                inputType: TextInputType.visiblePassword,
                title: 'confirm password',
                label: 'confirm your password',
                obscureText: true,
              ),
              CustomTextField(
                controller: emailController,
                icon: Icon(Icons.email),
                inputType: TextInputType.emailAddress,
                title: 'email(optional)',
                label: 'enter your email',
                validator: (value) {
                  if (value!.isEmpty) {}
                  if (!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                  ).hasMatch(value)) {
                    return 'enter valid email';
                  }
                  return null;
                },
                obscureText: false,
              ),
              CustomTextField(
                controller: addressController,
                icon: Icon(Icons.location_on),
                inputType: TextInputType.name,
                title: 'address(optional)',
                label: 'enter your address',
                obscureText: false,
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'already_have_account'.tr,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.go('/login');
                    },
                    child: Text(
                      'login'.tr,
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
                  if (formKey.currentState!.validate()) {
                    ref
                        .read(registerProvider.notifier)
                        .register(
                          fullName: fullNameController.text,
                          phoneNumber: phoneController.text,
                          password: passwordController.text,
                          email: emailController.text,
                          address: addressController.text,
                        );
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
                          registerState.isLoading
                              ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              )
                              : Text(
                                'create_account'.tr,
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
