import 'package:flutter/material.dart';
import 'package:fuji_maintenance_system/core/helper/validation_utils.dart';
import 'package:fuji_maintenance_system/core/routing/routes.dart';
import 'package:fuji_maintenance_system/core/translation/app_strings.dart';
import 'package:fuji_maintenance_system/core/widgets/custom_section_container.dart';
import 'package:fuji_maintenance_system/interfaces/admin/features/add%20client/presentation/widgets/custom_text_filed_beta.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationDetailsSection extends StatefulWidget {
  const LocationDetailsSection({
    super.key,
    required this.addressController,
    required this.locationController,
    required this.latController,
    required this.lngController,
  });

  final TextEditingController addressController;
  final TextEditingController locationController;
  final TextEditingController latController;
  final TextEditingController lngController;

  @override
  State<LocationDetailsSection> createState() => _LocationDetailsSectionState();
}

class _LocationDetailsSectionState extends State<LocationDetailsSection> {
  Future<void> _openMap() async {
    final result = await context.push(Routes.pickLocationScreen);

    if (result != null && result is LatLng) {
      widget.locationController.text =
          'Lat: ${result.latitude}, Lng: ${result.longitude}';
      widget.latController.text = result.latitude.toString();
      widget.lngController.text = result.longitude.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomSectionContainer(
      child: Column(
        children: [
          CustomTextFieldBeta(
            title: AppStrings.address.tr,
            keyboardType: TextInputType.text,
            textEditingController: widget.addressController,
            hintText: AppStrings.address.tr,
            icon: Icons.home,
            validator: (value) => ValidationUtils.validateAddress(value),
          ),
          GestureDetector(
            onTap: () async {
              await _openMap();
            },
            child: AbsorbPointer(
              absorbing: true,
              child: CustomTextFieldBeta(
                title: AppStrings.location.tr,
                keyboardType: TextInputType.text,
                textEditingController: widget.locationController,
                hintText: AppStrings.location.tr,
                icon: Icons.map,
                validator: (value) => ValidationUtils.validateAddress(value),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
