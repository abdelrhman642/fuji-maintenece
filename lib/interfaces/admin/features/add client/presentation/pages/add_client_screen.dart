import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/helper/validation_utils.dart';
import 'package:fuji_maintenance_system/core/routing/routes.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_app_bar_widget.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20client/data/models/add_client_request_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20client/presentation/cubit/add_client_cubit.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20client/presentation/widgets/custom_text_filed_beta.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20client/presentation/widgets/show_added_client_successfully_dialog.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddClientScreen extends StatefulWidget {
  const AddClientScreen({super.key});
  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController linkedController = TextEditingController();

  LatLng? _selectedLocation;
  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    addressController.dispose();
    locationController.dispose();
    linkedController.dispose();
    super.dispose();
  }

  void _clearControllers() {
    _formKey.currentState?.reset();
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    passwordController.clear();
    passwordConfirmationController.clear();
    addressController.clear();
    locationController.clear();
    linkedController.clear();
    _selectedLocation = null;
  }

  Future<void> _openMap() async {
    final result = await context.push(Routes.pickLocationScreen);

    if (result != null && result is LatLng) {
      setState(() {
        _selectedLocation = result;

        linkedController.text = result.toString();
      });
    }
  }

  Future<void> _pasteAndExtractLatLng() async {
    final clipboardData = await Clipboard.getData('text/plain');
    final url = clipboardData?.text ?? '';
    if (url.isNotEmpty) {
      final latLng = extractLatLngFromGoogleMapsUrl(url);
      if (latLng != null) {
        setState(() {
          _selectedLocation = latLng;
          linkedController.text = latLng.toString();
        });
        context.showSuccess('Location extracted from link!');
      } else {
        context.showError('Invalid Google Maps link.');
      }
    } else {
      context.showError('Clipboard is empty.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddClientCubit, AddClientState>(
      listener: (context, state) {
        if (state is AddClientLoading) {
          showLoadingDialog(context);
        }
        if (state is AddClientSuccess) {
          Navigator.of(context).pop(); // Close the loading dialog
          showAddedClientSuccessfullyDialog(context, () {
            _clearControllers();
          });
        } else if (state is AddClientFailure) {
          Navigator.of(context).pop(); // Close the loading dialog
          context.showError(state.error);
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: CustomAppBarWidget(title: AppStrings.addAClient.tr),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      CustomTextFieldBeta(
                        title: AppStrings.clientName,
                        keyboardType: TextInputType.text,
                        textEditingController: nameController,
                        hintText: AppStrings.clientName.tr,
                        icon: Icons.person,
                        validator:
                            (value) => ValidationUtils.validateName(value),
                      ),
                      CustomTextFieldBeta(
                        title: AppStrings.phone,
                        keyboardType: TextInputType.number,
                        textEditingController: phoneController,
                        hintText: AppStrings.phone.tr,
                        icon: Icons.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
                        ],
                        validator:
                            (value) =>
                                ValidationUtils.validatePhoneNumber(value),
                      ),
                      CustomTextFieldBeta(
                        title: AppStrings.email,
                        textEditingController: emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: AppStrings.email.tr,
                        icon: Icons.email,
                        // validator:
                        //     (value) => ValidationUtils.validateEmail(value),
                      ),

                      CustomTextFieldBeta(
                        title: AppStrings.password,
                        isPassword: true,
                        textEditingController: passwordController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: AppStrings.password.tr,
                        icon: Icons.lock,
                        validator:
                            (value) => ValidationUtils.validatePassword(value),
                      ),
                      CustomTextFieldBeta(
                        title: AppStrings.passwordConfirm,
                        isPassword: true,
                        textEditingController: passwordConfirmationController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: AppStrings.passwordConfirm.tr,
                        icon: Icons.lock,
                        validator:
                            (value) => ValidationUtils.validateConfirmPassword(
                              value,
                              passwordController.text,
                            ),
                      ),
                      CustomTextFieldBeta(
                        title: AppStrings.address,
                        keyboardType: TextInputType.text,
                        textEditingController: addressController,
                        hintText: AppStrings.address.tr,

                        icon: Icons.location_city_rounded,
                        validator:
                            (value) => ValidationUtils.validateAddress(value),
                      ),

                      // CustomTextFieldBeta(
                      //   title: AppStrings.address,
                      //   keyboardType: TextInputType.text,
                      //   textEditingController: linkedController,
                      //   hintText: AppStrings.address.tr,
                      //   icon: Icons.location_on,
                      // ),
                      Row(
                        children: [
                          Text(
                            AppStrings.location.tr,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColor.blackColor,
                            ),
                          ),
                          const Spacer(),
                          ElevatedButton.icon(
                            onPressed: _pasteAndExtractLatLng,
                            icon: const Icon(Icons.paste),
                            label: Text(AppStrings.pasteLink.tr),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primary,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(10, 36),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: _openMap,
                            icon: const Icon(Icons.map),
                            label: Text(AppStrings.pickOnMap.tr),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primary,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(10, 36),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                            ),
                          ),
                        ],
                      ),

                      IgnorePointer(
                        ignoring: true,
                        child: CustomTextFieldBeta(
                          onChanged: (value) {
                            linkedController.text =
                                extractLatLngFromGoogleMapsUrl(
                                  value,
                                )?.toString() ??
                                '';
                            _selectedLocation = extractLatLngFromGoogleMapsUrl(
                              value,
                            );
                          },

                          keyboardType: TextInputType.text,
                          textEditingController: linkedController,
                          hintText: AppStrings.location.tr,
                          icon: Icons.location_on_rounded,
                          iconColor: AppColor.primary,
                          validator:
                              (value) => ValidationUtils.validateAddress(value),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 36,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AddClientCubit>().addClient(
                          AddClientRequestModel(
                            name: nameController.text,
                            phone: phoneController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            passwordConfirmation:
                                passwordConfirmationController.text,
                            location: addressController.text,
                            longitude:
                                _selectedLocation?.longitude.toString() ?? '',
                            latitude:
                                _selectedLocation?.latitude.toString() ?? '',
                          ),
                        );
                      }
                    },
                    child: Text(AppStrings.save.tr),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

LatLng? extractLatLngFromGoogleMapsUrl(String url) {
  final regExp = RegExp(r'q=([-+]?\d*\.\d+),([-+]?\d*\.\d+)');
  final match = regExp.firstMatch(url);

  if (match != null) {
    final double lat = double.parse(match.group(1)!);
    final double lng = double.parse(match.group(2)!);
    return LatLng(lat, lng);
  }
  return null;
}
