import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/di/setup_services.dart';
import 'package:fuji_maintenance_system/core/helper/context_notification_extension.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/show_loading_dialog.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/service/webservice/api_service.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/widgets/custom_app_bar_widget.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/profile_response_entity.dart';
import '../widgets/location_picker_bottom_sheet.dart';

/// Edit profile screen for updating user information
class EditProfileScreen extends StatefulWidget {
  final ProfileResponseEntity profileData;

  const EditProfileScreen({super.key, required this.profileData});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _locationController;
  late final TextEditingController _longitudeController;
  late final TextEditingController _latitudeController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final user = widget.profileData.user;

    _nameController = TextEditingController(text: user.name);
    _phoneController = TextEditingController(text: user.phone);
    _emailController = TextEditingController(text: user.email);
    _locationController = TextEditingController(text: user.location ?? '');
    _longitudeController = TextEditingController(text: user.longitude ?? '');
    _latitudeController = TextEditingController(text: user.latitude ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    _longitudeController.dispose();
    _latitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: CustomAppBarWidget(title: AppStrings.profileDetails.tr),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildFormSection(),
          const SizedBox(height: 24),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildFormSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.grey3.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.accountInformation.tr,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColor.black,
            ),
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _nameController,
            label: AppStrings.fullName.tr,
            icon: Icons.person,
            hintText: AppStrings.enterFullName.tr,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Name is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _phoneController,
            label: AppStrings.phoneNumber.tr,
            icon: Icons.phone,
            hintText: AppStrings.enterPhoneNumber.tr,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Phone number is required';
              }
              // Basic phone validation
              if (!RegExp(r'^\+?[\d\s\-\(\)]+$').hasMatch(value.trim())) {
                return 'Please enter a valid phone number';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _emailController,
            label: AppStrings.emailAddress.tr,
            icon: Icons.email,
            hintText: AppStrings.enterEmail.tr,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Email is required';
              }
              // Basic email validation
              if (!RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              ).hasMatch(value.trim())) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildLocationField(),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _longitudeController,
                  label: AppStrings.longitude.tr,
                  icon: Icons.map,
                  hintText: '-74.025',
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      final double? parsed = double.tryParse(value);
                      if (parsed == null) {
                        return 'Invalid longitude';
                      }
                      if (parsed < -180 || parsed > 180) {
                        return 'Longitude must be between -180 and 180';
                      }
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  controller: _latitudeController,
                  label: AppStrings.latitude.tr,
                  icon: Icons.map,
                  hintText: '40.7145',
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      final double? parsed = double.tryParse(value);
                      if (parsed == null) {
                        return 'Invalid latitude';
                      }
                      if (parsed < -90 || parsed > 90) {
                        return 'Latitude must be between -90 and 90';
                      }
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hintText,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(icon, color: AppColor.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColor.grey3, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColor.grey3, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColor.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColor.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColor.error, width: 2),
        ),
        filled: true,
        fillColor: AppColor.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  /// Builds location field with map picker
  Widget _buildLocationField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.location.tr,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColor.black,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: _openLocationPicker,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColor.grey3, width: 1),
            ),
            child: Row(
              children: [
                Icon(Icons.location_on, color: AppColor.primary, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _locationController.text.isEmpty
                        ? 'Tap to select location from map'
                        : _locationController.text,
                    style: TextStyle(
                      fontSize: 16,
                      color:
                          _locationController.text.isEmpty
                              ? AppColor.grey2
                              : AppColor.black,
                    ),
                  ),
                ),
                Icon(Icons.map, color: AppColor.primary, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleSave,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primary,
          foregroundColor: AppColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child:
            _isLoading
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: const CustomLoadingIndicator(color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Text('Saving...'),
                  ],
                )
                : Text(
                  AppStrings.saveChanges.tr,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
      ),
    );
  }

  Future<void> _handleSave() async {
    if (!mounted) return;

    // Validate form
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final email = _emailController.text.trim();
    final location = _locationController.text.trim();
    final longitudeText = _longitudeController.text.trim();
    final latitudeText = _latitudeController.text.trim();

    if (name.isEmpty) {
      _showErrorSnackBar('Name is required');
      return;
    }

    if (phone.isEmpty) {
      _showErrorSnackBar('Phone number is required');
      return;
    }

    if (email.isEmpty) {
      _showErrorSnackBar('Email is required');
      return;
    }

    // Validate email format
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      _showErrorSnackBar('Please enter a valid email address');
      return;
    }

    // Validate phone format
    if (!RegExp(r'^\+?[\d\s\-\(\)]+$').hasMatch(phone)) {
      _showErrorSnackBar('Please enter a valid phone number');
      return;
    }

    double? longitude;
    double? latitude;

    if (longitudeText.isNotEmpty) {
      longitude = double.tryParse(longitudeText);
      if (longitude == null) {
        _showErrorSnackBar('Invalid longitude format');
        return;
      }
      if (longitude < -180 || longitude > 180) {
        _showErrorSnackBar('Longitude must be between -180 and 180');
        return;
      }
    }

    if (latitudeText.isNotEmpty) {
      latitude = double.tryParse(latitudeText);
      if (latitude == null) {
        _showErrorSnackBar('Invalid latitude format');
        return;
      }
      if (latitude < -90 || latitude > 90) {
        _showErrorSnackBar('Latitude must be between -90 and 90');
        return;
      }
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authRepository = AuthRepositoryImpl(
        apiService: getIt<ApiService>(),
      );

      final result = await authRepository.updateProfile(
        name: name,
        phone: phone,
        email: email,
        location: location.isEmpty ? null : location,
        longitude: longitude,
        latitude: latitude,
      );

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        result.fold(
          (failure) {
            _showErrorSnackBar('Update failed: ${failure.message}');
          },
          (updatedProfile) {
            _showSuccessSnackBar('Profile updated successfully');
            // Navigate back with updated data
            context.pop(updatedProfile);
          },
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _showErrorSnackBar('Update failed: $e');
      }
    }
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;

    context.showError(message);
  }

  void _showSuccessSnackBar(String message) {
    if (!mounted) return;

    context.showSuccess(message);
  }

  /// Opens location picker with map
  void _openLocationPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => LocationPickerBottomSheet(
            currentLocation: _locationController.text,
            currentLongitude: _longitudeController.text,
            currentLatitude: _latitudeController.text,
            onLocationSelected: (location, longitude, latitude) {
              setState(() {
                _locationController.text = location;
                _longitudeController.text = longitude.toString();
                _latitudeController.text = latitude.toString();
              });
            },
          ),
    );
  }
}
