import 'package:flutter/material.dart';
import 'package:flutter_project/core/constants/app_constants.dart';
import 'package:flutter_project/features/maintenance/presentation/screens/maintenance%D9%80view.dart';
import 'package:flutter_project/core/widgets/custom_Container.dart';
import 'package:flutter_project/core/widgets/custom_ElevatedButton.dart';
import 'package:flutter_project/core/widgets/custom_textfiled.dart';
import 'package:flutter_project/features/home/presentation/providers/home_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeView extends ConsumerWidget {
  HomeView({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);

    ref.listen<HomeState>(homeProvider, (previous, next) {
      if (next.client != null) {
        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40.h),
                  padding: EdgeInsets.only(top: 50.h),
                  height: 450.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        CustomContainer(title: next.client!.registrationNumber),
                        CustomContainer(title: next.client!.name),
                        CustomContainer(title: next.client!.phoneNumber),
                        CustomContainer(title: next.client!.address),
                        CustomContainer(
                          title: 'Contract date',
                          data: next.client!.contractDate,
                        ),
                        CustomContainer(
                          title: 'Naming the contract',
                          data: next.client!.namingContract,
                        ),
                        CustomElevatedbutton(
                          title: 'New Report',
                          color: AppColors.KBlackColor,
                          onPress: () {
                            context.go('/maintenance');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 100.h,
                  width: 97.w,
                  decoration: BoxDecoration(
                    color: AppColors.KPrimaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(22)),
                  ),
                  child: Image.asset(AppImages.profile),
                ),
              ],
            );
          },
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.KPrimaryColor,
        title: Text(
          'Choose a Client',
          style: TextStyle(
            fontSize: 18.sp,
            color: AppColors.KWhiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications, color: AppColors.KWhiteColor),
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Icon(Icons.menu, color: AppColors.KWhiteColor),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.MapImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            CustomTextField(
              controller: searchController,
              icon: Icon(Icons.search),
              inputType: TextInputType.name,
              label: 'Find the registration number',
              obscureText: false,
              onSubmitted: (value) {
                ref.read(homeProvider.notifier).findClient(value);
              },
            ),
            if (homeState.isLoading) Center(child: CircularProgressIndicator()),
            InkWell(
              onTap: () {
                ref
                    .read(homeProvider.notifier)
                    .findClient(searchController.text);
              },
              child: Container(
                margin: EdgeInsets.only(top: 300, left: 100),
                height: 37.h,
                width: 37.w,
                decoration: BoxDecoration(
                  color: AppColors.KPrimaryColor,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
