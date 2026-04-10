import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/helper/validation_utils.dart';
import 'package:fuji_maintenance_system/core/routing/routes.dart';
import 'package:fuji_maintenance_system/core/theme/app_color.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20client/presentation/widgets/custom_text_filed_beta.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/technicians/data/models/technician_model.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/technicians/data/models/update_technician_request.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/technicians/presentation/manager/technicians%20cubit/technicians_cubit.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void showEditTechnicianBottomSheet(
  BuildContext context,
  TechniciansCubit cubit,
  TechnicianModel technician,
) {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController(text: technician.name ?? '');
  final phoneController = TextEditingController(text: technician.phone ?? '');
  final emailController = TextEditingController(text: technician.email ?? '');
  final locationNameController = TextEditingController(
    text: technician.location ?? '',
  );
  final longitudeController = TextEditingController(
    text: technician.longitude ?? '',
  );
  final latitudeController = TextEditingController(
    text: technician.latitude ?? '',
  );
  final locationCoordinatesController = TextEditingController(
    text:
        (technician.latitude != null && technician.longitude != null)
            ? 'Lat: ${double.tryParse(technician.latitude ?? '')?.toStringAsFixed(6) ?? technician.latitude}, Lng: ${double.tryParse(technician.longitude ?? '')?.toStringAsFixed(6) ?? technician.longitude}'
            : '',
  );
  String selectedStatus = technician.status ?? 'inactive';

  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (bottomSheetContext) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 8,
            ),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Center(
                      child: Text(
                        AppStrings.updateTechnician.tr,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Name Input
                    CustomTextFieldBeta(
                      title: AppStrings.name.tr,
                      hintText: AppStrings.name.tr,
                      icon: Icons.person_outline,
                      textEditingController: nameController,
                      keyboardType: TextInputType.text,
                      validator: ValidationUtils.validateName,
                    ),

                    // Phone Input
                    CustomTextFieldBeta(
                      title: AppStrings.phone.tr,
                      hintText: AppStrings.phone.tr,
                      icon: Icons.phone_outlined,
                      textEditingController: phoneController,
                      keyboardType: TextInputType.phone,
                      validator: ValidationUtils.validatePhoneNumber,
                    ),

                    // Email Input
                    CustomTextFieldBeta(
                      title: AppStrings.email.tr,
                      hintText: AppStrings.enterEmail.tr,
                      icon: Icons.email_outlined,
                      textEditingController: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: ValidationUtils.validateOptionalEmail,
                    ),

                    // Location Name Input
                    CustomTextFieldBeta(
                      title: AppStrings.location.tr,
                      hintText: AppStrings.location.tr,
                      icon: Icons.location_on_outlined,
                      textEditingController: locationNameController,
                      keyboardType: TextInputType.text,
                    ),

                    // Location Coordinates Input with Map Button
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              LatLng? initialLocation;
                              if (longitudeController.text.isNotEmpty &&
                                  latitudeController.text.isNotEmpty) {
                                final lng = double.tryParse(
                                  longitudeController.text,
                                );
                                final lat = double.tryParse(
                                  latitudeController.text,
                                );
                                if (lng != null && lat != null) {
                                  initialLocation = LatLng(lat, lng);
                                }
                              }

                              final result = await context.push(
                                Routes.pickLocationScreen,
                                extra: initialLocation,
                              );

                              if (result != null && result is LatLng) {
                                setModalState(() {
                                  latitudeController.text =
                                      result.latitude.toString();
                                  longitudeController.text =
                                      result.longitude.toString();
                                  locationCoordinatesController.text =
                                      'Lat: ${result.latitude.toStringAsFixed(6)}, Lng: ${result.longitude.toStringAsFixed(6)}';
                                });
                              }
                            },
                            child: AbsorbPointer(
                              absorbing: true,
                              child: CustomTextFieldBeta(
                                title: 'Coordinates',
                                hintText: 'Select location from map',
                                icon: Icons.map_outlined,
                                textEditingController:
                                    locationCoordinatesController,
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              LatLng? initialLocation;
                              if (longitudeController.text.isNotEmpty &&
                                  latitudeController.text.isNotEmpty) {
                                final lng = double.tryParse(
                                  longitudeController.text,
                                );
                                final lat = double.tryParse(
                                  latitudeController.text,
                                );
                                if (lng != null && lat != null) {
                                  initialLocation = LatLng(lat, lng);
                                }
                              }

                              final result = await context.push(
                                Routes.pickLocationScreen,
                                extra: initialLocation,
                              );

                              if (result != null && result is LatLng) {
                                setModalState(() {
                                  latitudeController.text =
                                      result.latitude.toString();
                                  longitudeController.text =
                                      result.longitude.toString();
                                  locationCoordinatesController.text =
                                      'Lat: ${result.latitude.toStringAsFixed(6)}, Lng: ${result.longitude.toStringAsFixed(6)}';
                                });
                              }
                            },
                            icon: const Icon(Icons.map),
                            label: Text(AppStrings.pickLocation.tr),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primaryDark,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Status Selection
                    Text(
                      AppStrings.status.tr,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _buildSelectionCard(
                            icon: Icons.toggle_on,
                            label: AppStrings.activeLabel.tr,
                            isSelected: selectedStatus == 'active',
                            color: Colors.teal,
                            onTap: () {
                              setModalState(() {
                                selectedStatus = 'active';
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildSelectionCard(
                            icon: Icons.toggle_off,
                            label: AppStrings.inactiveLabel.tr,
                            isSelected: selectedStatus == 'inactive',
                            color: Colors.grey,
                            onTap: () {
                              setModalState(() {
                                selectedStatus = 'inactive';
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Update Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }

                          final request = UpdateTechnicianRequest(
                            name: nameController.text.trim(),
                            phone: phoneController.text.trim(),
                            email:
                                emailController.text.trim().isEmpty
                                    ? null
                                    : emailController.text.trim(),
                            location:
                                locationNameController.text.trim().isEmpty
                                    ? null
                                    : locationNameController.text.trim(),
                            longitude:
                                longitudeController.text.trim().isEmpty
                                    ? null
                                    : longitudeController.text.trim(),
                            latitude:
                                latitudeController.text.trim().isEmpty
                                    ? null
                                    : latitudeController.text.trim(),
                            status: selectedStatus,
                          );

                          cubit.updateTechnician(technician.id!, request);
                          Navigator.pop(bottomSheetContext);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryDark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          AppStrings.update.tr,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

Widget _buildSelectionCard({
  required IconData icon,
  required String label,
  required bool isSelected,
  required Color color,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: isSelected ? color.withOpacity(0.15) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? color : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: isSelected ? color : Colors.grey.shade400,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? color : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    ),
  );
}
